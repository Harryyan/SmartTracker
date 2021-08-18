//
//  TransactionPresenter.swift
//  TransactionPresenter
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI
import Combine

final class TransactionPresenter: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var transactionViewModels: [TransactionViewModel] = []
    
    private let interactor: TransactionInteractor
    private let router = TransactionListWireframe()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(interactor: TransactionInteractor) {
        self.interactor = interactor
        
        interactor.dataProvider.transactionDataPublisher.receive(on: RunLoop.main)
            .sink(receiveValue: update(result:))
            .store(in: &cancellables)
    }
    
    // MARK: - Internal
    
    func update(result: [Transaction]) {
        transactions = result
        transactionViewModels = result.enumerated().map {
            let viewModel = TransactionViewModel($1)
            
            if viewModel.currencyName == CURRENCY_USD {
                let rate = NSDecimalNumber(value: interactor.dataProvider.currencyRate)
                let amount = NSDecimalNumber(value: viewModel.amount)
                viewModel.displayAmount = rate.multiplying(by: amount).doubleValue
            }
            
            viewModel.idx = $0
            
            return viewModel
        }
    }
    
    func delete(transaction: Transaction) {
        interactor.delete(transaction: transaction)
    }
    
    func transactionFormView(with transactionViewModel: TransactionViewModel? = nil) -> some View {
        guard let transactionViewModel = transactionViewModel else {
            return router.transactionFormView(with: nil, and: interactor)
        }
        
        let transaction = self.transactions[transactionViewModel.idx]
        
        return router.transactionFormView(with: transaction, and: interactor)
    }
}
