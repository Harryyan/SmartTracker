//
//  TransactionTabView.swift
//  TransactionTabView
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI

struct TransactionTabView: View {
    @ObservedObject var presenter: TransactionPresenter
    
    @State private var isAddFormPresented = false
    @State private var transactionToEdit: TransactionViewModel?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(presenter.transactionViewModels, id: \.id) { transition in
                    Button(action: {
                        self.transactionToEdit = transition
                    }) {
                        TransactionRow(transaction: transition)
                    }
                }
                .onDelete(perform: onDelete)
                .sheet(item: $transactionToEdit, onDismiss: {
                    self.transactionToEdit = nil
                }) {
                    presenter.transactionFormView(with: $0)
                }
            }
            .sheet(isPresented: $isAddFormPresented) {
                presenter.transactionFormView()
            }
            .navigationBarItems(trailing: Button(action: addTapped) {
                Image(systemName: "plus")
            })
            .navigationBarTitle(TRANSACTION_NAVIGATION_TITLE)
        }
    }
    
    private func addTapped() {
        isAddFormPresented = true
    }
    
    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach {
            let transaction = presenter.transactions[$0]
            
            presenter.transactions.remove(at: $0)
            presenter.transactionViewModels.remove(at: $0)
            
            presenter.delete(transaction: transaction)
        }
    }
}
