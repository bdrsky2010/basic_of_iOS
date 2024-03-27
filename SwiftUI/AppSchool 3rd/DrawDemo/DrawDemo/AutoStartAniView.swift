//
//  AutoStartAniView.swift
//  DrawDemo
//
//  Created by Minjae Kim on 12/20/23.
//

import SwiftUI

struct AutoStartAniView: View {
	@State private var rotation: Double = 0
	@State private var isSpinning: Bool = true
	
	var body: some View {
		ZStack {
			Circle()
				.stroke(lineWidth: 2)
				.foregroundStyle(.blue)
				.frame(width: 360)
			
			Image(systemName: "forward.fill")
				.font(.largeTitle)
				.offset(y: -180)
				.rotationEffect(.degrees(rotation))
				.animation(.linear(duration: 5).repeatForever(autoreverses: false), value: rotation)
		}
		.onAppear {
			self.isSpinning.toggle()
			rotation = isSpinning ? 0 : 360
		}
		
	}
}

#Preview {
	AutoStartAniView()
}
