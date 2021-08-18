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
    
    func update(transaction: Transaction) {
        dataProvider.update(transaction: transaction)
    }
    
    func delete(transaction: Transaction) {
        dataProvider.delete(transaction: transaction)
    }
}
