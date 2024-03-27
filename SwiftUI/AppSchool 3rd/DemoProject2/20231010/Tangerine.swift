//
//  Tangerine.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/10/23.
//

import SwiftUI

struct Tangerine: View {
	@State private var num1: String = ""
	@State private var num2: String = ""
	@State private var box: String = ""
	@State private var remain: String = ""
	var body: some View {
		VStack {
			TextField("구매할 귤 갯수", text: $num1)
				.keyboardType(.numberPad)
			TextField("한 박스 당 귤 갯수", text: $num2)
				.keyboardType(.numberPad)
			Button(action: {
				guard let num1: Int = Int(num1) else { return }
				guard let num2: Int = Int(num2) else { return }
				self.box = String(num1 / num2)
				self.remain = String(num1 % num2)
			}, label: {
				Text("계산")
					.fontWeight(.bold)
			})
			.buttonStyle(.borderedProminent)
			.disabled(self.num1.isEmpty == false && self.num2.isEmpty == false ? false : true)
			Text("귤 박스의 수 : \(self.box)")
				.padding(10)
			Text("박스에 담고 남은 귤 수 : \(self.remain)")
		}
		.padding(10)
	}
}

#Preview {
	Tangerine()
}
