//
//  TransitionAniView.swift
//  DrawDemo
//
//  Created by Minjae Kim on 12/20/23.
//

import SwiftUI

struct TransitionAniView: View {
	@State private var isButtonVisible: Bool = true
	
	var body: some View {
		VStack {
			Toggle(isOn: $isButtonVisible.animation(.linear(duration: 0.5))) {
				Text("Show/Hide Button")
			}
			.padding()
			
			if isButtonVisible {
				Button {
					
				} label: {
					Text("Example Button")
				}
				.font(.largeTitle)
				//                .transition(.slide)
				//                .transition(.scale)
				//                .transition(.move(edge: .top))
				//                .transition(.fadeAndMove)
				.transition(.asymmetric(insertion: .scale, removal: .slide))  // 비대칭 전환
				
			}
		}
	}
}

// 전환 결합하기
// commbined(with:)을 이용하여 불투명도와 전환을 결합
extension AnyTransition {
	static var fadeAndMove: AnyTransition {
		AnyTransition.opacity.combined(with: .move(edge: .top))
	}
}

#Preview {
	TransitionAniView()
}
