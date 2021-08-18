//
//  SmartTrackerApp.swift
//  SmartTracker
//
//  Created by Harry Yan on 17/08/21.
//

import SwiftUI

@main
struct SmartTrackerApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    let dataProvider: DataLayer
    
    init() {
        dataProvider = DataLayer(context: PersistenceController.shared.container.viewContext)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(dataProvider)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                Task {
                    let _ = try? await self.dataProvider.fetchCurrency(url: CurrencyResponse.url)
                }
            }
        }
    }
}
