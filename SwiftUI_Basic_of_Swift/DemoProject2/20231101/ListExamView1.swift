//
//  ListExamView1.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct ListExamView1: View {
	var body: some View {
		List(1...10, id: \.self) { item in
			Text("item \(item)")
				.foregroundStyle(.blue)
		}
		.navigationTitle("SwiftUI List Quiz")
	}
}

#Preview {
	ListExamView1()
}
