//
//  SmartTrackerTests.swift
//  SmartTrackerTests
//
//  Created by Harry Yan on 17/08/21.
//

import XCTest
import Combine
@testable import SmartTracker

class SmartTrackerTests: XCTestCase {
    var dataProvier: DataProvider!
    var transactionInteractor: TransactionInteractor!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        dataProvier = DataLayer(context: PersistenceController(inMemory: true).container.viewContext)
        transactionInteractor = TransactionInteractor(dataProvider: dataProvier)
        
        cancellables = []
    }
    
    override func tearDown() {
        dataProvier = nil
        transactionInteractor = nil
        cancellables = []
    }
    
    func testAddTransaction() throws {
        // Given
        let transaction = Transaction(context: dataProvier.context)
        let date = Date()
        var newTransaction: Transaction?
        
        transaction.id = UUID()
        transaction.title = DONATION
        transaction.category = Category.donation(budget: BUDGET_DONATION).id
        transaction.amount = NSDecimalNumber(value: 40.00)
        transaction.currency = CURRENCY_NZD
        transaction.occuredOn = date
        
        // When
        transactionInteractor.upsert(transaction: transaction)
        
        // Then
        newTransaction = try wait(for: dataProvier.transactionDataPublisher).first
        
        XCTAssertNotNil(newTransaction, "Transaction should not be nil")
        XCTAssertNotNil(newTransaction?.id, "Transaction Id should not be nil")
        XCTAssertEqual(newTransaction?.title, DONATION)
        XCTAssertEqual(newTransaction?.category, Category.donation(budget: 100).id)
        XCTAssertEqual(newTransaction?.amount?.doubleValue, 40.00)
        XCTAssertEqual(newTransaction?.currency, CURRENCY_NZD)
        XCTAssertEqual(newTransaction?.occuredOn, date)
    }
    
    func testUpdateTransaction() throws {
        // Given
        let transaction = Transaction(context: dataProvier.context)
        var transactionToUpdate: Transaction?
        var transactionUpdated: Transaction?
        let date = Date()
        
        transaction.id = UUID()
        transaction.title = DONATION
        transaction.category = Category.donation(budget: 100).id
        transaction.amount = NSDecimalNumber(value: 40.00)
        transaction.currency = CURRENCY_NZD
        transaction.occuredOn = date
        
        // When
        transactionInteractor.upsert(transaction: transaction)
        
        // Then
        transactionToUpdate = try wait(for: dataProvier.transactionDataPublisher).first
        
        XCTAssertNotNil(transactionToUpdate, "Transaction should not be nil")
        XCTAssertNotNil(transactionToUpdate?.id, "Transaction Id should not be nil")
        
        // When
        transactionToUpdate?.title = "Donation_Alternative"
        if let transactionToUpdate = transactionToUpdate {
            transactionInteractor.upsert(transaction: transactionToUpdate)
        }
        
        // Then
        transactionUpdated = try wait(for: dataProvier.transactionDataPublisher).first
        
        XCTAssertNotNil(transactionUpdated, "Transaction should not be nil")
        XCTAssertEqual(transactionUpdated?.title, "Donation_Alternative")
        XCTAssertEqual(transactionUpdated?.id, transactionToUpdate?.id)
    }
    
    func testDeleteTransaction() throws {
        // Given
        let transactionToDelete = Transaction(context: dataProvier.context)
        let date = Date()
        var result: Transaction?
        
        transactionToDelete.id = UUID()
        transactionToDelete.title = DONATION
        transactionToDelete.category = Category.donation(budget: 100).id
        transactionToDelete.amount = NSDecimalNumber(value: 40.00)
        transactionToDelete.currency = CURRENCY_NZD
        transactionToDelete.occuredOn = date
        
        // When
        transactionInteractor.upsert(transaction: transactionToDelete)
        transactionInteractor.delete(transaction: transactionToDelete)
        
        // Then
        result = try wait(for: dataProvier.transactionDataPublisher).first
        
        XCTAssertNil(result, "Transaction should be nil")
        XCTAssertNil(result?.id, "Transaction ID should be nil")
    }
    
}
