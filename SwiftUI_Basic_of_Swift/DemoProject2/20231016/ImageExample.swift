//
//  ImageExample.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/16/23.
//

import SwiftUI

struct ImageExample: View {
	@State private var input: String = ""
	@State private var showText: String = ""
	
	var body: some View {
		VStack {
			Image("SML")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(.rect(cornerSize: CGSize(width: 15, height: 15)))
			HStack {
				Button(action: {}, label: { Text("HOME") })
					.buttonStyle(.borderedProminent)
				Spacer()
				Text(showText)
				Spacer()
				Button(action: {}, label: { Text("CALL") })
					.buttonStyle(.borderedProminent)
			}
			.padding(.top, 1)
			Spacer()
			HStack {
				TextField("입력해주세요", text: $input)
					.textFieldStyle(.roundedBorder)
				Button(action: {
					upper()
				}, label: {
					Text("HELLO BUTTON")
				})
				.buttonStyle(.borderedProminent)
			}
		}
		.padding()
		.background(Color.teal)
	}
	
	private func upper() {
		self.showText = input.uppercased()
	}
}

#Preview {
	ImageExample()
}
