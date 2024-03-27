//
//  ScrollView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/12/23.
//

import SwiftUI

struct Scroll: View {
	@State private var selection: Int = 0
	var body: some View {
		TabView {
			EvenOdd()
				.tabItem { Text("EvenOdd") }
				.tag(0)
			
			Difference()
				.tabItem { Text("Difference") }
				.tag(1)
			
			BasketBall()
				.tabItem { Text("Basketball") }
				.tag(2)
		}
	}
}

#Preview {
	Scroll()
}
