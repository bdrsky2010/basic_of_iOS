//
//  Difference.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/12/23.
//

import SwiftUI

struct Difference: View {
	@State private var inputNum1: Int?
	@State private var inputNum2: Int?
	@State private var result: String = ""
	
	let title: String = "두 수의 차이를 알려주는 계산기"
	var body: some View {
		VStack {
			Text(title)
				.font(.system(size: 50))
				.fontWeight(.bold)
				.frame(minWidth: 350, alignment: .leading)
			Group {
				Text("첫 번째 정수")
					.frame(minWidth: 350, alignment: .leading)
				TextField("첫 번째 정수 입력", value: $inputNum1, format: .number)
					.textFieldStyle(.roundedBorder)
					.padding(.bottom, 40)
				
				Text("두 번째 정수")
					.frame(minWidth: 350, alignment: .leading)
				TextField("두 번째 정수 입력", value: $inputNum2, format: .number)
					.textFieldStyle(.roundedBorder)
					.padding(.bottom, 40)
				
				
				Button(action: {getDifference()}, label: {
					Text("계산")
				})
				.buttonStyle(.borderedProminent)
				
				Text(result)
					.font(.title3)
			}
			.padding(.horizontal, 20)
		}
	}
	private func getDifference() -> Void {
		guard let num1 = inputNum1 else { return }
		guard let num2 = inputNum2 else { return }
		result = String(abs(max(num1, num2) - min(num1, num2)))
	}
}

#Preview {
    Difference()
}
