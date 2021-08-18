//
//  TransactionListWireframe.swift
//  TransactionListWireframe
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI

struct TransactionListWireframe {
    
    func transactionFormView(with transaction: Transaction?,
                             and interactor: TransactionInteractor) -> some View {
        let viewModel = TransactionViewModel(transaction)
        
        return TransactionFormView(transaction: transaction, presenter: TransactionFormPresenter(interactor: interactor), viewModel: viewModel)
    }
}
