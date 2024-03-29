//
//  SwiftDataTCAApp.swift
//  SwiftDataTCA
//
//  Created by Minjae Kim on 3/29/24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct SwiftDataTCAApp: App {
	@Dependency(\.databaseService) var databaseService
	var modelContext: ModelContext {
		guard let modelContext = try? self.databaseService.context() else {
			fatalError("Could not find modelcontext")
		}
		return modelContext
	}
	let store: StoreOf<ContentFeature> = Store(initialState: ContentFeature.State()) {
		ContentFeature()
	}
	
    var body: some Scene {
        WindowGroup {
			ContentView(store: store)
        }
    }
}
