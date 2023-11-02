//
//  AddNewCar.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

//
struct AddNewCar: View {
	
	@StateObject var carStore: CarStore
	@Binding var path: NavigationPath
	
	@State private var isHybrid: Bool = false
	@State private var name: String = ""
	@State private var description: String = ""
	
	var body: some View {
		Form {
			Section {
				Image(systemName: "car.fill")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.padding()
				
				DataInput(title: "Model", userInput: $name)
				DataInput(title: "Description", userInput: $description)
				
				Toggle(isOn: $isHybrid) {
					Text("Hybrid").font(.headline)
				}.padding()
			}
			Button(action: addNewCar) {
				Text("Add Car")
			}
		}
	}
	
	func addNewCar() {
		// 프로젝트 간략화를 위해 사진 라이브러리에서 사진을 가져오지 않고, 기존 이미지를 재사용
		let newCar: Car = Car(id: UUID().uuidString, name: name, description: description, isHybrid: isHybrid, imageName: "tesla_model_3")
		carStore.cars.append(newCar)
		path.removeLast()
	}
}

// 새로운 차량의 상제 정보 입력을 위한 하위 뷰를 선언
struct DataInput: View {
	
	var title: String
	@Binding var userInput: String
	
	var body: some View {
		VStack(alignment: HorizontalAlignment.leading) {
			Text(title)
				.font(.headline)
			TextField("Enter \(title)", text: $userInput)
				.textFieldStyle(RoundedBorderTextFieldStyle())
		}
		.padding()
	}
}

//#Preview {
//	// 테스트를 위해 차량 목록을 전달
//	AddNewCar(carStore: CarStore(cars: carData))
//}
