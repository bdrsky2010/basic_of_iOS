//
//  BasketBall.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/12/23.
//

import SwiftUI

struct BasketBall: View {
	@State private var inputNum: Int?
	@State private var box: String = ""
	var body: some View {
		VStack {
			TextField("농구공 개수", value: $inputNum, format: .number)
				.modifier(MyTextField())
				.onChange(of: inputNum) { box = getboxNum() }
			
			
			Text("필요한 상자의 수: \(box)")
				.font(.title3)
		}
		.background(Image("basketball")
			.aspectRatio(contentMode: .fill)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.ignoresSafeArea())
	}
	private func getboxNum() -> String {
		guard let number = inputNum else { return "" }
		return String(number % 5 != 0 ? number / 5 + 1 : number / 5)
	}
}

#Preview {
	BasketBall()
}
