//
//  NavigationExamView2.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct NavigationExamView2: View {
	struct SecondView: View {
		
		@Binding var text: String
		
		var body: some View {
			VStack {
				TextField("Hello", text: $text)
					.textFieldStyle(.roundedBorder)
					.padding()
			}
			.navigationTitle("Second View")
		}
	}
	
	@State private var text: String = ""
	
	var body: some View {
		NavigationStack {
			VStack {
				Text(text)
					.frame(maxWidth: .infinity)
					.font(.largeTitle)
				NavigationLink(destination: { SecondView(text: $text) }) {
					Text("textfield 뷰로 이동")
						.font(.largeTitle)
				}
			}
			.navigationTitle("First View")
		}
	}
}

#Preview {
    NavigationExamView2()
}
