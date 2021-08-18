//
//  SmartTrackerApp.swift
//  SmartTracker
//
//  Created by Harry Yan on 17/08/21.
//

import SwiftUI

@main
struct SmartTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
