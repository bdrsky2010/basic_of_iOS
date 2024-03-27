//
//  ListView2.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/31/23.
//

import SwiftUI

struct ListView2: View {
	var body: some View {
		// 리스트 셀은 여러 컴포넌트를 조합하여 셀에 표시할 수 있다
		List {
			HStack {
				Image(systemName: "trash.circle.fill")
					.resizable()
					.frame(width: 30, height: 30)
				Text("Take out the trash")
			}
			
			HStack {
				Image(systemName: "person.2.fill")
					.resizable()
					.frame(width: 30, height: 30)
				Text("Pick up the kids")
			}
			
			HStack {
				Image(systemName: "car.fill")
					.resizable()
					.frame(width: 30, height: 30)
				Text("Wash the car")
			}
		}
	}
}

#Preview {
	ListView2()
}
