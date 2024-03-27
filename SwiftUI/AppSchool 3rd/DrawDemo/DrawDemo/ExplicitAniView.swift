//
//  ExplicitAniView.swift
//  DrawDemo
//
//  Created by Minjae Kim on 12/20/23.
//

import SwiftUI

struct ExplicitAniView: View {
	var body: some View {
		VStack {
			ButtonExplicitAniView()
			CircleExplicitAniView()
		}
	}
}

// 명시적 애니메이션
struct CircleExplicitAniView: View {
	
	@State private var yellowCircle = false
	
	var body: some View {
		Circle()
			.fill(yellowCircle ? .yellow : .blue)
			.frame(width: 100, height: 100)
			.onTapGesture {
				withAnimation {
					yellowCircle.toggle()
				}
			}
		
	}
}

// 명시적 애니메이션
struct ButtonExplicitAniView: View {
	
	@State private var rotation: Double = 0
	@State private var scale: CGFloat = 1
	
	var body: some View {
		Button {
			withAnimation(.linear(duration: 2)) {
				// 회전 애니메이션만 적용
				self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0)
			}
			self.scale = (self.scale < 2.8 ? self.scale + 0.3 : 1)
		} label: {
			Text("Click to animate")
				.rotationEffect(.degrees(rotation))
				.scaleEffect(scale)
		}
		
	}
}

#Preview {
	ExplicitAniView()
}
