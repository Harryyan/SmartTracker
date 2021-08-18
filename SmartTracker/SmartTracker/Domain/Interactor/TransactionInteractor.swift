//
//  TransactionInteractor.swift
//  TransactionInteractor
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

final class TransactionInteractor {
    let dataProvider: DataProvider
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func upsert(transaction: Transaction) {
        dataProvider.upsert(transaction: transaction)
    }
    
    func delete(transaction: Transaction) {
        dataProvider.delete(transaction: transaction)
    }
}
