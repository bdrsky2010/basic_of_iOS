//
//  ContentView.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var network = NewsAPI.shared
	
    var body: some View {
		NavigationStack {
			List {
				NavigationLink {
					NewsList()
				} label: {
					Text("NewsList")
				}

				NavigationLink {
					WeatherList()
				} label: {
					Text("WeatherList")
				}
				
			}
		}
    }
}

#Preview {
    ContentView()
}
