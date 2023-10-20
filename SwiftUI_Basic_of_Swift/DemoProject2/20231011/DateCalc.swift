//
//  DateCalc.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/11/23.
//

import SwiftUI

struct DateCalc: View {
	@State private var input: Int = 0
	@State private var second: Int = 0
	@State private var minute: Int = 0
	@State private var hour: Int = 0
	var body: some View {
		VStack {
			HStack {
				TextField("몇 초?", value: $input, format: .number)
					.textFieldStyle(.roundedBorder)
					.keyboardType(.numberPad)
				Button(action: {
					self.hour = self.input / 60 / 60
					self.minute = self.input / 60 % 60
					self.second = self.input % 60
				}, label: {
					Text("계산")
				})
				.buttonStyle(.borderedProminent)
				
			}
			HStack {
				Text("\(self.hour)시")
				Text("\(self.minute)분")
				Text("\(self.second)초")
			}
			.frame(width: 380, height: 30)
			.background(.white)
			.overlay {
				RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
					.stroke(Color.white, lineWidth: 2)
			}
		}
		.padding(10)
		.background(Image("bear")
			.resizable()
			.scaledToFill()
			.opacity(0.6))
	}
}

#Preview {
	DateCalc()
}
