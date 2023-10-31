//
//  ListView3.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/31/23.
//

import SwiftUI

struct ListView3: View {
	var body: some View {
		// 리스트 구분자 및 행 수정 P.300
		List {
			Text("Wash the car")
				.listRowSeparator(.hidden) // 구분선 숨김
			Text("Pick up kids from school bus @ 3pm")
				.listRowSeparatorTint(.green) // 구분선 색상 변경
			Text("Auction the kids on eBay")
				.listRowSeparatorTint(.red)
			Text("Order Pizza for dinner")
				.listRowBackground(Color.indigo) // 배경 View 설정
		}
	}
}

#Preview {
	ListView3()
}
