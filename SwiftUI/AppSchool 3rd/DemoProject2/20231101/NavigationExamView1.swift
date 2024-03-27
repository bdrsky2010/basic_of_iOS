//
//  NavigationExamView1.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct NavigationExamView1: View {
	
	struct SecondView: View {
		let title: String
		
		var body: some View {
			VStack {
				
			}
			.navigationTitle(title)
		}
	}
	
	@State private var title: String = "First View"
	
	var body: some View {
		NavigationStack {
			VStack {
				NavigationLink(destination: SecondView(title: title)
					.onAppear {
						 self.title = "Second View"
					 }
					 .onDisappear {
						 self.title = "First View"
					 }) { Text("다음 뷰로 이동") }
			}
			.navigationTitle(title)
		}
	}
}

#Preview {
	NavigationExamView1()
}
