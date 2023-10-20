//
//  RoundDown.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/10/23.
//

import SwiftUI

struct RoundDown: View {
	@State private var num: String = ""
	@State private var result: String = ""
    var body: some View {
			VStack {
				TextField("first", text: $num)
					.keyboardType(.numberPad)
				Button(action: {
					guard let input: Int = Int(num) else { return }
					self.result = String((input) - (input % 100))
				}, label: {
					Text("버림")
						.fontWeight(.bold)
				})
				.disabled(self.num.isEmpty)
				Text("버림 수 : \(self.result)")
			}
			.padding(10)
    }
}

#Preview {
    RoundDown()
}
