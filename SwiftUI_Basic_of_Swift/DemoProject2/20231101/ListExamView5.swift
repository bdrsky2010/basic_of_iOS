//
//  ListExamView5.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct ListExamView5: View {
	
	@State private var items: [Int] = Array(1...10)
	
	var body: some View {
		List {
			ForEach(items, id: \.self) { item in
				Text("item \(item)")
			}
			.onDelete(perform: delete)
			.onMove(perform: move)
		}
		.toolbar { EditButton() }
		.navigationTitle("SwiftUI List Quiz")
	}
	
	func delete(IndexSet indexSet: IndexSet) {
		self.items.remove(atOffsets: indexSet)
	}
	
	func move(Indices indices: IndexSet, NewOffset newOffset: Int) {
		self.items.move(fromOffsets: indices, toOffset: newOffset)
	}
}

#Preview {
	ListExamView5()
}
