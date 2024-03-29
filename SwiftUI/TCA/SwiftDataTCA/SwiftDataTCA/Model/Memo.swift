//
//  MemoModel.swift
//  SwiftDataTCA
//
//  Created by Minjae Kim on 3/29/24.
//

import Foundation
import SwiftData

@Model
final class Memo: Equatable {
	let id: UUID
	var title: String
	var content: String
	var timestamp: Date
	
	init(id: UUID, title: String, content: String, timestamp: Date) {
		self.id = id
		self.title = title
		self.content = content
		self.timestamp = timestamp
	}
}
