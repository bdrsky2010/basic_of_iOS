//
//  OutlineGroupExamView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/8/23.
//

import SwiftUI

struct OutlineGroupExamView: View {
	@State private var filterExpanded_1: Bool = true
	@State private var filterExpanded_2: Bool = true
	
	var body: some View {
		Form {
			DisclosureGroup(isExpanded: $filterExpanded_1) {
				Text("B")
				DisclosureGroup(isExpanded: $filterExpanded_2) {
					Text("D")
					Text("E")
				} label: {
					Text("C")
				}
			} label: {
				Text("A")
			}
			Text("F")
		}
	}
}

#Preview {
	OutlineGroupExamView()
}
