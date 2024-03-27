//
//  ContentView.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var network = WeatherAPI.shared
	
    var body: some View {
		NavigationStack {
			List {
				NavigationLink {
					NewsList()
				} label: {
					Text("NewsList")
				}

				NavigationLink {
					if !network.posts.isEmpty {
						WeatherList(weather: $network.posts[0], name: network.current?.name ?? "")
					}
				} label: {
					Text("WeatherList")
				}
				
				NavigationLink {
					MidFcstinfoServiceView()
				} label: {
					Text("MidFcstinfoService")
				}

				
			}
		}
		.onAppear {
			network.feachData()
			TTSManager.shared.play("안녕하세요")
			TTSManager.shared.stop()
		}
    }
}

#Preview {
    ContentView()
}
