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
    
    @Published var categorySums: [CategorySum] = []
    
    init(interactor: CategoryListInteractor) {
        self.interactor = interactor
        
        interactor.dataProvider.categoryDataPublisher.receive(on: RunLoop.main)
            .sink(receiveValue: update(result:))
            .store(in: &cancellables)
    }
    
    func update(result: [CategorySum]) {
        categorySums = result.map {
            let sum = interactor.dataProvider.sum(for: $0.category.id, at: interactor.dataProvider.currencyRate)
            let categorySum = CategorySum(sum: sum, category: $0.category)
            return categorySum
        }
    }
    
    func fetchCurrencyRate() {
        Task {
            try? await interactor.fetchCurrencyRate()
        }
    }
}
