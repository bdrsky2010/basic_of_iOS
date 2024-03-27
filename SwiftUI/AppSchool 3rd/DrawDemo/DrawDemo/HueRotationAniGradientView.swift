//
//  HueRotationAniGradientView.swift
//  DrawDemo
//
//  Created by Minjae Kim on 12/20/23.
//

import SwiftUI

struct HueRotationAniGradientView: View {
	@State private var animateGradient = true
	
	var body: some View {
		LinearGradient(colors: [.purple, .yellow],
					   startPoint: .topLeading,
					   endPoint: .bottomTrailing)
		.ignoresSafeArea()
		.hueRotation(.degrees(animateGradient ? 90 : 0))
		.onAppear {
			withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
				animateGradient.toggle()
			}
		}
	}
}

#Preview {
	HueRotationAniGradientView()
}
