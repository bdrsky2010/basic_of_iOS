//
//  ContentView.swift
//  CSVReadTest
//
//  Created by Minjae Kim on 1/22/24.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var vm = DrinkViewModel()
	
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
		.task {
			vm.decodeJson(drinkType: .beer)
		}
    }
}

#Preview {
    ContentView()
}
