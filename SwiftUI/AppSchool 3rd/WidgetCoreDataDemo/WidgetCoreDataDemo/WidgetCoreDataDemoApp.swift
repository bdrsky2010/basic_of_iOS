//
//  WidgetCoreDataDemoApp.swift
//  WidgetCoreDataDemo
//
//  Created by Minjae Kim on 12/28/23.
//

import SwiftUI

@main
struct WidgetCoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
