//
//  ListExamView3.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct ListExamView3: View {
	
	@State private var isCheckShow: [Bool] = Array(repeating: false, count: 10)
	
	var body: some View {
		List(1...10, id: \.self) { item in
			HStack {
				Text("item \(item)")
					.onTapGesture {
						self.isCheckShow = Array(repeating: false, count: 10)
						self.isCheckShow[item - 1].toggle()
					}
				Spacer()
				isCheckShow[item - 1] ? Image(systemName: "checkmark.square.fill").foregroundStyle(.red) : nil
			}
		}
		.navigationTitle("SwiftUI List Quiz")
	}
}

#Preview {
	ListExamView3()
}
