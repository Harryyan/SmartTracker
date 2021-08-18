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
                ForEach (presenter.categorySums, id: \.id) {
                    CategoryRow(category: $0.category, sum: $0.sum)
                }
            }
            .navigationBarTitle("Categories")
        }
    }

}
