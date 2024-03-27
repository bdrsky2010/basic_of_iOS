//
//  CoreDataDemo2App.swift
//  CoreDataDemo2
//
//  Created by Minjae Kim on 12/27/23.
//

import SwiftUI

@main
struct CoreDataDemo2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
			CoreDataView()
                .environment(\.managedObjectContext,
							  persistenceController.container.viewContext)
        }
    }
}
