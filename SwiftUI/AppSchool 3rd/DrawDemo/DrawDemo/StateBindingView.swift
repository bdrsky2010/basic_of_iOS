//
//  StateBindingView.swift
//  DrawDemo
//
//  Created by Minjae Kim on 12/20/23.
//

import SwiftUI

struct StateBindingView: View {
	@State private var visibility = false
	
	var body: some View {
		VStack {
			Toggle(isOn: $visibility.animation(.linear(duration: 1))) {
				Text("Toggle Text Views")
			}
			.padding()
			
			if visibility {
				Text("Hello World")
					.font(.largeTitle)
			}
			
			if !visibility {
				Text("Goodbye World")
					.font(.largeTitle)
			}
		}
		
	}
}

#Preview {
	StateBindingView()
}
