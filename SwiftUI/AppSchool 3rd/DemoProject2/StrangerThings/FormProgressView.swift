//
//  FormProgressView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct FormProgressView: View {
	let value: Int
    var body: some View {
		HStack {
			ProgressView(value: (Double(value) * 0.2))
			Spacer()
			Text("\(value) / 5 페이지")
				.font(.caption)
		}.padding()
    }
}

//#Preview {
//	var value: Double = 0.2
//	FormProgressView(value: value)
//}
