//
//  CategoryRepository.swift
//  CategoryRepository
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

final class CategoryRepository: CategoryProvider {
    var categoryExpensePublisher: Published<[CategoryExpense]>.Publisher { $categoryExpenses }
    @Published var categoryExpenses: [CategoryExpense] = []
    
    // MARK: - Init
    
    init() {
        loadCategoryExpenses()
    }
    
    // MARK: - Internal
    
    func loadCategoryExpenses() {
        var categoryExpenses: [CategoryExpense] = []
        
        for category in Category.all {
            let categoryExpense = CategoryExpense(expenseInTotal: 0.00, category: category)
            categoryExpenses.append(categoryExpense)
        }
        
        self.categoryExpenses = categoryExpenses
    }
}
