//
//  ListExamView2.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct ListExamView2: View {
	
	var body: some View {
		List {
			ForEach(1..<6) { section in
				let row: [Int] = Array(1...3)
				Section {
					ForEach(row, id: \.self) { row in
						Text("Row \(row)")
							.foregroundStyle(.blue)
					}
				} header: {
					Text("Section \(section)").foregroundStyle(.black)
				} footer: {
					HStack {
						Spacer()
						Text("\(row.count) 건")
					}
				}
			}
		}
		.navigationTitle("SwiftUI List Quiz")
	}
}

#Preview {
	ListExamView2()
}
