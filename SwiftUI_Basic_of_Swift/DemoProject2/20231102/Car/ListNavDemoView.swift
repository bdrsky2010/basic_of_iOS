//
//  ListNavDemoView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct ListNavDemoView: View {
	
	@StateObject var carStore: CarStore = CarStore(cars: carData)
	@State private var stackPath: NavigationPath = NavigationPath()
	
	var body: some View {
		NavigationStack(path: $stackPath) {
			List {
				ForEach(0..<carStore.cars.count, id:\.self) { i in
					NavigationLink(value: i) {
						ListCell(car: carStore.cars[i])
					}
				}
				.onDelete(perform: deleteItem)
				.onMove(perform: moveItem)
			}
			.navigationDestination(for: Int.self) { i in
				CarDetail(selectedCar: carStore.cars[i])
			}
			.navigationDestination(for: String.self) { _ in
				AddNewCar(carStore: self.carStore, path: $stackPath)
			}
			.navigationTitle("EV Cars")
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					NavigationLink(value: "Add Car") {
						Text("Add").foregroundStyle(.blue)
					}
				}
				ToolbarItem(placement: .topBarTrailing) {
					EditButton()
				}
			}
		}
	}
	func deleteItem(at offsets: IndexSet) {
		carStore.cars.remove(atOffsets: offsets)
	}
	
	func moveItem(from source: IndexSet, to destination: Int) {
		carStore.cars.move(fromOffsets: source, toOffset: destination)
	}
}

// 하위 뷰로 추출
struct ListCell: View {
	
	var car: Car
	
	var body: some View {
		HStack {
			Image(car.imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 100, height: 60)
				.clipShape(.rect(cornerRadius: 6.0))
			Text(car.name)
		}
	}
}

#Preview {
	ListNavDemoView()
}
