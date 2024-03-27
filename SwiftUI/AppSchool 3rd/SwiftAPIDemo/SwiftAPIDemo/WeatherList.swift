//
//  WeatherList.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct WeatherList: View {
	@Binding var weather: Weather
	let name: String
	
	var body: some View {
		ZStack {
			Color.black
				.ignoresSafeArea()
				.opacity(0.12)
			RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
				.padding(.horizontal, 20)
				.frame(height: 400)
				.foregroundStyle(.white)
			VStack {
				let iconUrlString = "https://openweathermap.org/img/wn/\(weather.icon)@2x.png"
				AsyncImage(url: URL(string: iconUrlString))
				VStack {
					Text(weather.main)
					Text(weather.description)
				}
			}
			.padding(.horizontal, 40)
			.navigationTitle(name)
		}
	}
}

#Preview {
	// main: "Clouds", description: "overcast clouds", icon: "04d")
	WeatherList(weather: .constant(Weather(main: "Clouds", description: "overcast clouds", icon: "04d")), name: "몰러")
}
