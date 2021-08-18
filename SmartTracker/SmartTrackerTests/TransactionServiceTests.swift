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
        transaction.currency = CURRENCY_USD
        transaction.occuredOn = date
        
        // When
        transactionInteractor.upsert(transaction: transaction)
        
        newTransaction = try wait(for: dataProvier.transactionDataPublisher).first
        
        // Then
        XCTAssertNotNil(newTransaction, "Transaction should not be nil")
        XCTAssertNotNil(newTransaction?.id, "Transaction Id should not be nil")
        XCTAssertEqual(newTransaction?.title, "Donation")
        XCTAssertEqual(newTransaction?.category, Category.donation(budget: 100).id)
        XCTAssertEqual(newTransaction?.amount?.doubleValue, 40.00)
        XCTAssertEqual(newTransaction?.currency, "USD")
        XCTAssertEqual(newTransaction?.occuredOn, date)
    }
    
}
