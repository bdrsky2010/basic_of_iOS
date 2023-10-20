//
//  OneChange.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/10/23.
//

import SwiftUI

struct OneChange: View {
	@State private var num: String = ""
	@State private var result: String = ""
		var body: some View {
			VStack {
				TextField("아무 숫자나 입력해라", text: $num)
					.keyboardType(.numberPad)
				Button(action: {
					guard let input: Int = Int(num) else { return }
					self.result = String((input) - (input % 10) + 1)
				}, label: {
					Text("1의 자리 1로 바꾸기")
						.fontWeight(.bold)
				})
				.disabled(self.num.isEmpty)
				Text("1의 자리 1로 바꾼 수 : \(self.result)")
			}
			.padding(10)
		}
}

#Preview {
    OneChange()
}
