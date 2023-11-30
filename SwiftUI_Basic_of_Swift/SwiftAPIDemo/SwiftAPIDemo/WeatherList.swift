//
//  WeatherList.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct WeatherList: View {
	@StateObject var network = WeatherAPI.shared
	
	var body: some View {
		List {
			ForEach(network.posts, id: \.self) { result in
				HStack {
					AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(result.icon)@2x.png"))
					VStack {
						Text(result.main)
						Text(result.description)
						Text(result.icon)
					}
				}
			}
		}
		.onAppear {
			network.feachData()
		}
	}
}

#Preview {
    WeatherList()
}
