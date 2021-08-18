//
//  DataProviderServiceTests.swift
//  DataProviderServiceTests
//
//  Created by Harry Yan on 18/08/21.
//

import XCTest
import Combine
@testable import SmartTracker

class DataProviderServiceTests: XCTestCase {
    var dataProvier: DataProvider!
    var transactionInteractor: TransactionInteractor!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        dataProvier = DataLayer(context: PersistenceController(inMemory: true).container.viewContext)
        transactionInteractor = TransactionInteractor(dataProvider: dataProvier)
        
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        
        dataProvier = nil
    }
    
    func testTotalExpenseOfCategories() throws {
        // Given
        let rate = 1.44
        var transactions: [Transaction] = []
        
        seeding()
        
        // When
        transactions = try wait(for: dataProvier.transactionDataPublisher)
        
        // Then
        let foodExpense = dataProvier.sumOfExpense(of: Category.food(budget: 500).id, at: rate)
        let transpotationExpense = dataProvier.sumOfExpense(of: Category.transportation(budget: 400).id, at: rate)
        let otherExpense = dataProvier.sumOfExpense(of: Category.other(budget: 200).id, at: rate)
        
        XCTAssertEqual(transactions.count, 3)
        XCTAssertEqual(foodExpense, 68.8)
        XCTAssertEqual(transpotationExpense, 28.8)
        XCTAssertEqual(otherExpense, 0)
    }
    
    private func seeding() {
        let date = Date()
        
        let foodTransaction_NZD = Transaction(context: dataProvier.context)
        let foodTransaction_USD = Transaction(context: dataProvier.context)
        let transportationTransaction = Transaction(context: dataProvier.context)
        
        foodTransaction_NZD.id = UUID()
        foodTransaction_NZD.title = FOOD
        foodTransaction_NZD.category = Category.food(budget: 500).id
        foodTransaction_NZD.amount = NSDecimalNumber(value: 40.00)
        foodTransaction_NZD.currency = CURRENCY_NZD
        foodTransaction_NZD.occuredOn = date
        
        foodTransaction_USD.id = UUID()
        foodTransaction_USD.title = FOOD
        foodTransaction_USD.category = Category.food(budget: 500).id
        foodTransaction_USD.amount = NSDecimalNumber(value: 20.00)
        foodTransaction_USD.currency = CURRENCY_USD
        foodTransaction_USD.occuredOn = date
        
        transportationTransaction.id = UUID()
        transportationTransaction.title = TRANSPORTATION
        transportationTransaction.category = Category.transportation(budget: 300).id
        transportationTransaction.amount = NSDecimalNumber(value: 20.00)
        transportationTransaction.currency = CURRENCY_USD
        transportationTransaction.occuredOn = date
        
        transactionInteractor.upsert(transaction: foodTransaction_NZD)
        transactionInteractor.upsert(transaction: foodTransaction_USD)
        transactionInteractor.upsert(transaction: transportationTransaction)
    }
}
