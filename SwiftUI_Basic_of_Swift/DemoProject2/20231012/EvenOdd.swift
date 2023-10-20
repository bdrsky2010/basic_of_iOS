//
//  SwiftUIView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/12/23.
//

import SwiftUI

struct EvenOdd: View {
	@State private var inputNum: Int?
	@State private var evenOdd: String = ""
	var body: some View {
		VStack {
			TextField("숫자 입력", value: $inputNum, format: .number)
				.modifier(MyTextField())
				.onChange(of: inputNum) { evenOdd = getEvenOdd() }
			
			Image(systemName: "ellipsis.circle")
				.resizable()
				.frame(width: 30, height: 30)
				.foregroundStyle(.gray)
				.symbolEffect(.variableColor, value: inputNum)
			
			Text(evenOdd)
				.font(.title3)
		}
	}
	private func getEvenOdd() -> String {
		guard let number = inputNum else { return "" }
		return number % 2 == 0 ? "EVEN" : "ODD"
	}
}

// textfield 커스텀
struct MyTextField: ViewModifier {
		func body(content: Content) -> some View {
				content
						.textFieldStyle(.roundedBorder)
						.keyboardType(.decimalPad)
						.foregroundColor(.black)
						.padding([.leading, .trailing], 100)
						.multilineTextAlignment(.center)
		}
}

#Preview {
	EvenOdd()
}
