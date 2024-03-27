//
//  ListView5.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/31/23.
//

import SwiftUI

struct ListView5: View {
	
	@State private var stackPath: NavigationPath = NavigationPath()
	
	@State private var toggleStatus: Bool = true
	
	@State var listData: [ToDoItem] = [
		ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
		ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
		ToDoItem(task: "Wash the car", imageName: "car.fill")
	]
	
	var body: some View {
		
		Text("\(stackPath.count)")
		
		NavigationStack(path: $stackPath) {
			List {
				Section("Toggle") {
					Toggle(isOn: $toggleStatus) {
						Text("Allow Notifications")
					}
				}
				
				NavigationLink(value: listData.first ?? ToDoItem(task: "", imageName: "")) {
					Text("test")
				}
				
				// 값 타입별 내비게이션
				NavigationLink(value: listData.count) {
					Text("View Task Count")
				}
				
				Section(header: Text("To Do Tasks")) {
					ForEach(listData) { item in
						NavigationLink(value: item.task) {
							HStack {
								Image(systemName: item.imageName)
									.resizable()
									.frame(width: 30, height: 30)
								Text(item.task)
							}
						}
					}
					.onDelete(perform: { indexSet in
						// 데이터 소스에서 항목을 삭제하는 코드 p.310
					})
					.onMove(perform: { indices, newOffset in
						// 항목을 재배열하는 코드 p.311
					})
				}
			}
			.navigationTitle("To Do List")
			.navigationDestination(for: ToDoItem.self) { item in
				Text("Number of tasks = \(item.imageName)")
			}
			.navigationDestination(for: Int.self) { count in
				Text("Number of tasks = \(count)")
			}
			.navigationDestination(for: String.self) { task in
				Text("Selected task = \(task)")
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
}

#Preview {
	ListView5()
}
