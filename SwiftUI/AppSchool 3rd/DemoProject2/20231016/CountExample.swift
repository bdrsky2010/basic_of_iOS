//
//  CountExample.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/16/23.
//

import SwiftUI

struct CountExample: View {
	@State private var count: Int = 0
	var body: some View {
		GeometryReader { geometry in
			VStack {
				Spacer()
				Text("\(count)")
				Spacer()
				Button("COUNT") {
					self.count += 1
				}
				.frame(width: geometry.size.width)
				.padding(5)
				.foregroundStyle(.white)
				.background(Color.indigo)
				.clipShape(.rect(cornerSize: CGSize(width: 5, height: 5)))
			}
			.background(Color.teal)
		}
		
//		VStack {
//			Spacer()
//			Text("\(count)")
//			Spacer()
//			Button(action: { self.count += 1
//			}, label: {
//				Text("COUNT")
//					.frame(maxWidth: .infinity)
//			})
//			.buttonStyle(.borderedProminent)
//		}
//		.padding()
	}
}

#Preview {
	CountExample()
}
