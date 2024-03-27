//
//  NavigationExamListView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct NavigationExamListView: View {
	var body: some View {
		List {
			NavigationLink(destination: NavigationExamView1()) {
				Text("예제 1번")
			}
			NavigationLink(destination: NavigationExamView2()) {
				Text("예제 2번")
			}
			NavigationLink(destination: NavigationExamView3()) {
				Text("예제 3번")
			}
			NavigationLink(destination: NavigationExamView4()) {
				Text("예제 4번")
			}
		}
	}
}

#Preview {
	NavigationExamListView()
}
