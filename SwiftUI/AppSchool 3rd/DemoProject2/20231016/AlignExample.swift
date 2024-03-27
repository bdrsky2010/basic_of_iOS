//
//  AlignExample.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/16/23.
//

import SwiftUI

struct AlignExample: View {
	var body: some View {
		GeometryReader { geometry in
			VStack {
				Button("Button") { }
					.frame(width: geometry.size.width)
					.padding(5)
					.foregroundStyle(Color.white)
					.background(Color.indigo)
					.clipShape(.rect(cornerSize: CGSize(width: 5, height: 5)))
				
				Spacer()
				Button("Button") { }
					.frame(width: geometry.size.width, height: geometry.size.height / 4 * 3)
					.padding(5)
					.foregroundStyle(Color.white)
					.background(Color.indigo)
					.clipShape(.rect(cornerSize: CGSize(width: 5, height: 5)))
				
				Spacer()
				Button("Button") { }
					.frame(width: geometry.size.width)
					.padding(5)
					.foregroundStyle(Color.white)
					.background(Color.indigo)
					.clipShape(.rect(cornerSize: CGSize(width: 5, height: 5)))
			}
		}
		
//		VStack {
//			Button(action: {}, label: {
//				Text("Button")
//					.frame(maxWidth: .infinity)
//			})
//			.buttonStyle(.borderedProminent)
//			
//			Spacer()
//			
//			Button(action: {}, label: {
//				Text("Button")
//					.frame(maxWidth: .infinity)
//					.frame(maxHeight: .infinity)
//			})
//			.foregroundStyle(.white)
//			.background(Color.blue)
//			.clipShape(.rect(cornerSize: CGSize(width: 10, height: 10)))
//			.frame(maxHeight: .infinity)
//			
//			Spacer()
//			
//			Button(action: {}, label: {
//				Text("Button")
//					.frame(maxWidth: .infinity)
//			})
//			.buttonStyle(.borderedProminent)
//		}
//		.padding()
	}
}

#Preview {
	AlignExample()
}
