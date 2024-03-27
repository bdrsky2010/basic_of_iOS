//
//  ListExamView4.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct ListExamView4: View {
	
	@State private var toggleStatus: [Bool] = Array(repeating: true, count: 10)
	
	var body: some View {
		List(1...10, id: \.self) { item in
			HStack {
				Text("item \(item)")
					.bold(toggleStatus[item - 1])
				Spacer()
				Toggle("", isOn: $toggleStatus [item - 1])
			}
		}
		.navigationTitle("SwiftUI List Quiz")
	}
}

#Preview {
	ListExamView4()
}
