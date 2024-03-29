//
//  Database.swift
//  SwiftDataTCA
//
//  Created by Minjae Kim on 3/29/24.
//

import Foundation
import SwiftData
import Dependencies

public struct Database {
	var context: () throws -> ModelContext
}

fileprivate let appContext: ModelContext = {
	let schema = Schema([
		Memo.self
	])
	let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
	do {
		let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
		return ModelContext(container)
	} catch {
		fatalError("Could not create ModelContainer: \(error)")
	}
}()

extension Database: DependencyKey {
	public static var liveValue = Self(
		context: { appContext }
	)
}

extension DependencyValues {
	var databaseService: Database {
		get { self[Database.self] }
		set { self[Database.self] = newValue }
	}
}
