//
//  ListView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/31/23.
//

import SwiftUI

struct ListView: View {
	var body: some View {
		// 가장 단순한 형태의 List 표현
		// 하나 이상 뷰의 각 행을 수직 방향의 목록으로 정보를 표현
		List {
			Text("first")
			Text("second")
			Text("third")
			Text("fourth")
		}
	}
}

#Preview {
	ListView()
}
