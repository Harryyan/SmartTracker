//
//  TransactionViewModel.swift
//  TransactionViewModel
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

final class TransactionViewModel: ObservableObject, Identifiable {
    var transaction: Transaction?
    
    @Published var title = ""
    @Published var amount: Double = 0
    @Published var displayAmount: Double = 0
    @Published var occuredOn: Date
    @Published var categoryName: String
    @Published var currencyName: String
    @Published var selectedCurrency = ""
    @Published var selectedCategory = ""
    @Published var showCurrencyDrop = false
    @Published var showCategoryDrop = false
    
    var id: UUID
    var idx = -1
    
    init(_ transaction: Transaction?) {
        self.transaction = transaction
        
        id = transaction?.id ?? UUID()
        title = transaction?.title ?? ""
        currencyName = transaction?.currency ?? CURRENCY_NZD
        categoryName = transaction?.category ?? Category.other(budget: 0).id
        occuredOn = transaction?.occuredOn ?? Date()
        
        if let amount = transaction?.amount {
            self.amount = amount.doubleValue
            self.displayAmount = self.amount
        }
    }
}
