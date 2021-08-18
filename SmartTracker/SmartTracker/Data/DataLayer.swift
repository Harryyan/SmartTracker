//
//  DataLayer.swift
//  DataLayer
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation
import CoreData
import Combine
import SwiftUI

final class DataLayer: DataProvider {
    @AppStorage(RATE) var rate: Double = 1.0
    
    var context: NSManagedObjectContext
    var categoryRepository: CategoryProvider
    var transactionRepository: TransactionProvider
    
    var categoryExpensePublisher: Published<[CategoryExpense]>.Publisher { $categoryExpenses }
    @Published var categoryExpenses: [CategoryExpense] = []
    
    var transactionDataPublisher: Published<[Transaction]>.Publisher { $transactions }
    @Published var transactions: [Transaction] = []
    
    lazy var currencyRate: Double = {
        return rate
    }()
    
    private var categoryExpensesCancellables = Set<AnyCancellable>()
    private var transactionCancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        categoryRepository = CategoryRepository()
        transactionRepository = TransactionRepository(context: self.context)
        
        categoryRepository.categoryExpensePublisher
            .assign(to: \.categoryExpenses, on: self)
            .store(in: &categoryExpensesCancellables)
        
        transactionRepository.transactionPublisher
            .assign(to: \.transactions, on: self)
            .store(in: &transactionCancellables)
    }
    
    // MARK: - Internal
    
    func update(transaction: Transaction) {
        transactionRepository.save(transaction: transaction)
    }
    
    func delete(transaction: Transaction) {
        transactionRepository.delete(transaction: transaction)
    }
    
    func sumOfExpense(of category: String, at rate: Double) -> Double {
        let results = transactionRepository.loadCurrentMonthTransactions(for: category)
        var expense: Double = 0
        
        _ = results.map {
            if let amount = $0.amount {
                if $0.currency == CURRENCY_USD {
                    let rate = NSDecimalNumber(value: rate)
                    expense += amount.multiplying(by: rate).doubleValue
                } else {
                    expense += amount.doubleValue
                }
            }
        }
        
        return expense
    }
    
    func fetchCurrency(url: URL) async throws -> Double {
        let task = Task { () -> CurrencyResponse in
            try await fetchAndDecode(url: url)
        }
        
        let response: CurrencyResponse
        
        do {
            response = try await task.value
            
            Task {
                await MainActor.run {
                    self.rate = response.quotes[USDNZD] ?? self.rate
                    
                    self.reloadData()
                }
            }
            
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        
        return rate
    }
    
    // MARK: - Private
    
    private func fetchAndDecode(url: URL) async throws -> CurrencyResponse {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(CurrencyResponse.self, from: data)
        
        return decodedData
    }
    
    private func reloadData() {
        self.categoryRepository.loadCategoryExpenses()
        self.transactionRepository.loadAllTransactions()
    }
}

extension DataLayer: ObservableObject {}
