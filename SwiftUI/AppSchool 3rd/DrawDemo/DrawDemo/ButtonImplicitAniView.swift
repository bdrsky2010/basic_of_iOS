//
//  ButtonImplicitAniView.swift
//  DrawDemo
//
//  Created by Minjae Kim on 12/20/23.
//

import SwiftUI

struct ButtonImplicitAniView: View {
	@State private var rotation: Double = 0
	@State private var scale: CGFloat = 1
	
	var body: some View {
		Button {
			self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0)
			self.scale = (self.scale < 2.8 ? self.scale + 0.3 : 1)
		} label: {
			Text("Click to animate")
				.rotationEffect(.degrees(rotation))
			// repeatCount() 수정자 : 지정된 횟수만큼 애니메이션을 반복
			//                .animation(.linear(duration: 1).repeatCount(2, autoreverses: true), value: rotation)
			// repeatForever() 수정자 : 애니메이션을 무한 반복
				.animation(.linear(duration: 1).repeatForever(autoreverses: true), value: rotation)
			//                .animation(.spring(response: 1, dampingFraction: 0.2, blendDuration: 0), value: rotation)
				.scaleEffect(scale)
		}
		
	}
}

#Preview {
	ButtonImplicitAniView()
}
