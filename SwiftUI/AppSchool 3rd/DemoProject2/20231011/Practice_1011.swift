//
//  practice_1011.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/11/23.
//

import SwiftUI
struct Practice_1011: View {
	
	var body: some View {
		NavigationView {
			VStack {
				NavigationLink(destination: BasicView(), label: {
					Text("Next View")
				})
			}
			.padding(100)
			.background(Color.teal)
			.navigationTitle("챕터 20.4~21")
		}
	}
}

#Preview {
	Practice_1011()
}
