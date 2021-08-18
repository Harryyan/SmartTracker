//
//  CategoryListInteractor.swift
//  CategoryListInteractor
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

final class CategoryListInteractor {
    let dataProvider: DataProvider
    
    init (dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    @discardableResult
    func fetchCurrencyRate() async throws -> Double {
        let rate = try await dataProvider.fetchCurrency(url: CurrencyResponse.url)
        return rate
    }
}
