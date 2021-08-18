//
//  CategoryListPresenter.swift
//  CategoryListPresenter
//
//  Created by Harry Yan on 18/08/21.
//

import Combine
import SwiftUI

final class CategoryListPresenter: ObservableObject {
    private let interactor: CategoryListInteractor
    private var cancellables = Set<AnyCancellable>()
    
    @Published var expenses: [CategoryExpense] = []
    
    // MARK: - Init
    
    init(interactor: CategoryListInteractor) {
        self.interactor = interactor
        
        interactor.dataProvider.categoryExpensePublisher.receive(on: RunLoop.main)
            .sink(receiveValue: update(result:))
            .store(in: &cancellables)
    }
    
    //MARK : - Internal
    
    func update(result: [CategoryExpense]) {
        expenses = result.map {
            let expense = interactor.dataProvider.sumOfExpense(of: $0.category.id, at: interactor.dataProvider.currencyRate)
            let categorySum = CategoryExpense(expenseInTotal: expense, category: $0.category)
            return categorySum
        }
    }
    
    func fetchCurrencyRate() {
        Task {
            try? await interactor.fetchCurrencyRate()
        }
    }
}
