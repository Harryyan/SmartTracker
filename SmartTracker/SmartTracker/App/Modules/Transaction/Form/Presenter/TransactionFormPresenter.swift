//
//  TransactionFormPresenter.swift
//  TransactionFormPresenter
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

final class TransactionFormPresenter: ObservableObject {
    private let interactor: TransactionInteractor
    
    @Published var alertMsg = String()
    @Published var showAlert = false
    
    // MARK: - Init
    
    init(interactor: TransactionInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - Internal
    
    func save(transaction: Transaction?, transactionViewModel: TransactionViewModel) {
        let title = transactionViewModel.title.trimmingCharacters(in: .whitespacesAndNewlines)
        if title.isEmpty || title == "" {
            alertMsg = TRANSACTION_TITLE_ALERT
            showAlert = true
            
            return
        }
        
        let transactionLog: Transaction
        
        if let transaction = transaction {
            transactionLog = transaction
        } else {
            transactionLog = Transaction(context: interactor.dataProvider.context)
        }
        
        transactionLog.id = transactionViewModel.id
        transactionLog.title = transactionViewModel.title
        transactionLog.amount = NSDecimalNumber(value: transactionViewModel.amount)
        transactionLog.currency = transactionViewModel.currencyName
        transactionLog.category = transactionViewModel.categoryName
        transactionLog.occuredOn = transactionViewModel.occuredOn
        
        interactor.update(transaction: transactionLog)
    }
}
