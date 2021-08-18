//
//  RootView.swift
//  RootView
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var dataProvider: DataLayer
    
    var body: some View {
        TabView {
            CategoryTabView(presenter:
                                CategoryListPresenter(interactor:
                                                        CategoryListInteractor(dataProvider: dataProvider)))
                .tabItem {
                    VStack {
                        Text("Dashboard")
                        Image(systemName: "chart.pie")
                    }
                }
                .tag(0)
            
            TransactionTabView(presenter:
                                TransactionPresenter(interactor:
                                                        TransactionInteractor(dataProvider: dataProvider)))
                .tabItem {
                    VStack {
                        Text("Transactions")
                        Image(systemName: "tray")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
