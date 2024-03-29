//
//  MemoDatabase.swift
//  SwiftDataTCA
//
//  Created by Minjae Kim on 3/29/24.
//

import Foundation
import SwiftData
import Dependencies

public struct MemoDatabase {
	var fetchAll: @Sendable () throws -> [Memo]
	var fetch: @Sendable (FetchDescriptor<Memo>) throws -> [Memo]
	var add: @Sendable (Memo) throws -> Void
	var delete: @Sendable (Memo) throws -> Void
	
	enum MemoError: Error {
		case add
		case delete
	}
}

extension MemoDatabase: DependencyKey {
	public static let liveValue = Self(
		fetchAll: {
			do {
				@Dependency(\.databaseService.context) var context
				let memoContext = try context()
				
				let descriptor = FetchDescriptor<Memo>(sortBy: [SortDescriptor(\.timestamp)])
				return try memoContext.fetch(descriptor)
			} catch {
				return []
			}
		},
		fetch: { descriptor in
			do {
				@Dependency(\.databaseService.context) var context
				let memoContext = try context()
				
				return try memoContext.fetch(descriptor)
			} catch {
				return []
			}
		},
		add: { model in
			do {
				@Dependency(\.databaseService.context) var context
				let memoContext = try context()
				
				memoContext.insert(model)
			} catch {
				throw MemoError.add
			}
		},
		delete: { model in
			do {
				@Dependency(\.databaseService.context) var context
				let memoContext = try context()
				
				memoContext.delete(model)
			} catch {
				throw MemoError.delete
			}
		})
}

extension DependencyValues {
	var swiftData: MemoDatabase {
		get { self[MemoDatabase.self] }
		set { self[MemoDatabase.self] = newValue }
	}
}
