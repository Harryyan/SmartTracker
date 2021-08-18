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
    
    
    
}
