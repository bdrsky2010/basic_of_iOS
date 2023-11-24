//
//  ContentView.swift
//  UIVewDemo
//
//  Created by Minjae Kim on 11/24/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
			
			MyScrollView(text: "UIView is SwiftUI")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
