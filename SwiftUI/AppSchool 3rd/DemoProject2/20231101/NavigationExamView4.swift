//
//  NavigationExamView4.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct NavigationExamView4: View {
	struct SecondView: View {
		
		@Environment(\.editMode) private var editMode
		
		@State private var text: String = "Hello"
		
		var body: some View {
			VStack {
				TextField("Hello", text: $text)
					.disabled(!(editMode?.wrappedValue.isEditing ?? false))
					.textFieldStyle(.roundedBorder)
					.padding()
			}
			.toolbar { EditButton() }
			.navigationTitle("Second View")
		}
	}
	
	var body: some View {
		NavigationStack {
			NavigationLink(destination: { SecondView() }) {
				Text("textfield 뷰로 이동")
					.font(.largeTitle)
			}
			.navigationTitle("First View")
		}
	}
}

#Preview {
	NavigationExamView4()
}
