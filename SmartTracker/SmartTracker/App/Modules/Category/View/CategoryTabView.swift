//
//  CategoryTabView.swift
//  CategoryTabView
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI

struct CategoryTabView: View {
    @ObservedObject var presenter: CategoryListPresenter
    
    var body: some View {
        NavigationView {
            List {
                ForEach (presenter.expenses, id: \.id) {
                    CategoryRow(category: $0.category, expenseInTotal: $0.expenseInTotal)
                }
            }
            .navigationBarTitle(CATEGORY_NAVIGATION_TITLE)
        }
    }

}
