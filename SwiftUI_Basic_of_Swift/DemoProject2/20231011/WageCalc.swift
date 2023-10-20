//
//  WageCalc.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/11/23.
//

import SwiftUI

struct WageCalc: View {
	@State private var hour: Int = 0
	@State private var wage: Int = 0
	var body: some View {
		VStack {
			HStack {
				TextField("근무 시간 입력", value: $hour, format: .number)
					.textFieldStyle(.roundedBorder)
					.keyboardType(.numberPad)
				Button(action: { calcwage() }, label: { Text("계산") })
					.buttonStyle(.borderedProminent)
			}
			HStack {
				Text("총 근무시간: \(self.hour)시간")
				Text("총 급여는 \(self.wage)원 입니다.")
			}
			.frame(width: 380, height: 30)
			.background(.white)
			.overlay {
				RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
					.stroke(Color.white, lineWidth: 1)
			}
		}
		.padding(10)
		.background(Image("conv")
			.resizable()
			.scaledToFill()
			.opacity(0.6))
	}
	func calcwage() {
		if self.hour > 8 {
			let overtime: Int = self.hour - 8
			let wage: Int = (self.hour - overtime) * 10000
			let overwage: Int = (overtime * Int(10000 * 1.5))
			self.wage = wage + overwage
		}
		else { self.wage = self.hour * 10000 }
	}
}
	#Preview {
		WageCalc()
	}
