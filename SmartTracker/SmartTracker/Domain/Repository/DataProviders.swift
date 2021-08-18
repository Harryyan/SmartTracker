//
//  DataProvider.swift
//  DataProvider
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation
import CoreData
import SwiftUI

protocol DataProvider: AnyObject {
    var context: NSManagedObjectContext { get set }
    
    var transactionDataPublisher: Published<[Transaction]>.Publisher { get }
    var categoryExpensePublisher: Published<[CategoryExpense]>.Publisher { get }
    
    var currencyRate: Double { get set }
    
    func update(transaction: Transaction)
    func delete(transaction: Transaction)
    func sum(for category: String, at rate: Double) -> Double
    
    func fetchCurrency(url: URL) async throws -> Double
}

protocol CategoryProvider: AnyObject {
    var categoryExpensePublisher: Published<[CategoryExpense]>.Publisher { get }
    
    func loadCategoryExpenses()
}

protocol TransactionProvider: AnyObject {
    var transactionPublisher: Published<[Transaction]>.Publisher { get }
    
    func loadAllTransactions()
    func save(transaction: Transaction)
    func delete(transaction: Transaction)
    
    func loadCurrentMonthTransactions(for category: String) -> [Transaction]
}
