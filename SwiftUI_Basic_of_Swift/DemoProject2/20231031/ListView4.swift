//
//  ListView4.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/31/23.
//

import SwiftUI

// 동적 리스트
// - 리스트에 표시할 데이터는 Id...
// - id 프로퍼티 필수 : 각 항목을 고유하게 식별하는데 사용
// - Hashable 프로토콜을 따르는 모든 스위프트 타입이나 커스텀 타입이 가능
// - UUID() 메서드는 각 항목마다 고유한 ID를 자동으로 생성하는데 사용
struct ToDoItem: Identifiable, Hashable {
	var id: UUID = UUID()
	var task: String
	var imageName: String
}

struct ListView4: View {
	
	@State private var toggleStatus: Bool = true
	
	@State var listData: [ToDoItem] = [
		ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
		ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
		ToDoItem(task: "Wash the car", imageName: "car.fill")
	]
	
	var body: some View {
		List {
			Section("Toggle") {
				Toggle(isOn: $toggleStatus) {
					Text("Allow Notifications")
				}
			}
			
			Section(header: Text("To Do Tasks")) {
				ForEach(listData) { item in
					HStack {
						Image(systemName: item.imageName)
							.resizable()
							.frame(width: 30, height: 30)
						Text(item.task)
					}
				}
			}
		}
		// 새로 고침 동작을 추가
		.refreshable {
			listData = [
				ToDoItem(task: "Oreder dinner", imageName: "dollarsign.circle.fill"),
				ToDoItem(task: "Call financial advisor", imageName: "phone.fill"),
				ToDoItem(task: "Sell the kids", imageName: "person.2.fill")
			]
		}
	}
}

#Preview {
	ListView4()
}
