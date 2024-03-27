//
//  ListExampleListView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/31/23.
//

import SwiftUI

struct ListExampleListView: View {
	var body: some View {
		List {
			NavigationLink(destination: ListView()) {
				Text("List 기본 형태")
			}
			NavigationLink(destination: ListView2()) {
				Text("List 수정하기")
			}
			NavigationLink(destination: ListView3()) {
				Text("동적 List")
			}
			NavigationLink(destination: ListView4()) {
				Text("새로고침 List")
			}
			NavigationLink(destination: ListView5()) {
				Text("NavigationStack List")
			}
			NavigationLink(destination: ListExamView1()) {
				Text("List 예제 1번")
			}
			NavigationLink(destination: ListExamView2()) {
				Text("List 예제 2번")
			}
			NavigationLink(destination: ListExamView3()) {
				Text("List 예제 3번")
			}
			NavigationLink(destination: ListExamView4()) {
				Text("List 예제 4번")
			}
			NavigationLink(destination: ListExamView5()) {
				Text("List 예제 5번")
			}
			NavigationLink(destination: ListExamView6()) {
				Text("List 예제 6번")
			}
		}
	}
}

#Preview {
	ListExampleListView()
}
