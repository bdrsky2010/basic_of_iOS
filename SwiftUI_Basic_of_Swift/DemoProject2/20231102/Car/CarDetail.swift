//
//  CarDetail.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI


// 상세 뷰 설계
struct CarDetail: View {
	
	let selectedCar: Car
	
	var body: some View {
		Form {
			Section {
				Image(selectedCar.imageName)
					.resizable()
					.clipShape(.rect(cornerRadius: 12.0))
					.aspectRatio(contentMode: .fit)
					.padding()
				
				Text(selectedCar.name)
					.font(.headline)
				Text(selectedCar.description)
					.font(.body)
				HStack {
					Text("Hybrid").font(.headline)
					Spacer()
					selectedCar.isHybrid ? Image(systemName: "checkmark.circle.fill")
						.foregroundStyle(.blue) : Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
				}
			} header: {
				Text("Car Details")
			}
		}
	}
}

#Preview {
	CarDetail(selectedCar: carData[0])
}
