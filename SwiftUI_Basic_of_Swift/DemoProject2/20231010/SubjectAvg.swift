//
//  SubjectAvg.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/10/23.
//

import SwiftUI

struct SubjectAvg: View {
	@State private var swift: String = ""
	@State private var ios: String = ""
	@State private var web: String = ""
	@State private var avg: String = ""
	var body: some View {
		VStack {
			TextField("Swift 점수 입력", text: $swift)
				.keyboardType(.numberPad)
			TextField("iOS 점수 입력", text: $ios)
				.keyboardType(.numberPad)
			TextField("Web 점수 입력", text: $web)
				.keyboardType(.numberPad)
			Button(action: {
				guard let swift: Int = Int(swift) else { return }
				guard let ios: Int = Int(ios) else { return }
				guard let web: Int = Int(web) else { return }
				self.avg = String(Double(swift + ios + web) / 3)
			}, label: {
				Text("계산")
					.fontWeight(.bold)
			})
			.buttonStyle(.borderedProminent)
			.disabled(self.swift.isEmpty == false && self.ios.isEmpty == false && self.web.isEmpty == false ? false : true)
			Text("과목 평균 : \(self.avg)")
		}
		.padding(10)
	}
}

#Preview {
    SubjectAvg()
}
