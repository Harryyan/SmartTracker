//
//  TransactionViewModelExtension.swift
//  TransactionViewModelExtension
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

extension TransactionViewModel {
    
    var relativeDateText: String {
        DateUtils.relativeDateFormatter.localizedString(for: occuredOn, relativeTo: Date())
    }
    
    var dateText: String {
        DateUtils.dateFormatter.string(from: occuredOn)
    }
    
    var amountText: String {
        DateUtils.numberFormatter.string(from: NSNumber(value: displayAmount)) ?? ""
    }
}
