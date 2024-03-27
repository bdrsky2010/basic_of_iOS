//
//  SwiftDataPracApp.swift
//  SwiftDataPrac
//
//  Created by Minjae Kim on 12/14/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPracApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
			Item.self, Mangjae.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
