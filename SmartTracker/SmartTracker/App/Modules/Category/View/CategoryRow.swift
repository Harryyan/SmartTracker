//
//  CategoryRow.swift
//  CategoryRow
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI

struct CategoryRow: View {
    let category: Category
    let expenseInTotal: Double
    
    var body: some View {
        HStack {
            CategoryImageView(category: category)
            Text(category.id)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                TextView(text: "\(category.budget)", type: .subtitle_1).foregroundColor(Color.main_color)
                Spacer()
                TextView(text: String(format: "%.2f", category.budget - expenseInTotal), type: .button).foregroundColor(category.budget - expenseInTotal >= 0 ? Color.main_green : Color.main_red)
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: .donation(budget: 500), sum: 600)
    }
}
