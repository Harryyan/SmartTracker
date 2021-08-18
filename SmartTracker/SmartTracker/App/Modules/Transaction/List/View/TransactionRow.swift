//
//  TransactionRow.swift
//  TransactionRow
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: TransactionViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            CategoryImageView(category: Category(name: transaction.categoryName))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(transaction.title).font(.headline)
                Text(transaction.categoryName).font(.subheadline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack {
                    Text(transaction.amountText).font(.headline)
                }
                Spacer()
                Text(transaction.dateText).font(.subheadline)
            }
        }
        .padding(.vertical, 4)
    }
}
