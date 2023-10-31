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
		}
	}
}

#Preview {
	ListExampleListView()
}
