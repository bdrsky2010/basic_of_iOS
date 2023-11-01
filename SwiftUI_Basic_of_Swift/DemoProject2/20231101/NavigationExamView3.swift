//
//  NavigationExamView3.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct NavigationExamView3: View {
	
	@State private var title: String = "First View"
	
	var body: some View {
		NavigationStack {
			NavigationLink(value: Color.blue) {
				Text("다음 뷰로 이동")
			}
			.navigationDestination(for: Color.self) { color in
				VStack {
				}
				.frame(maxWidth: .infinity)
				.frame(maxHeight: .infinity)
				.background(color)
				.navigationBarBackButtonHidden()
				.navigationTitle("Second View")
			}
			.navigationTitle(title)
		}
	}
}

#Preview {
	NavigationExamView3()
}
