//
//  WeatherAPI.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct Current: Decodable {
	let weather: [Weather]
	let main: Main
	let name: String
}

struct Main: Decodable {
	let temp: Double
	let temp_min: Double
	let temp_max: Double
}

struct Weather: Decodable, Hashable {
	let main: String
	let description: String
	let icon: String
}

class WeatherAPI: ObservableObject {
	static let shared = WeatherAPI()
	private init() { }
	@Published var posts = [Weather]()
	@Published var current: Current?
	
	
	private var apiKey: String? {
		get { getValueOfPlistFile("ApiKeys", "WEATHER_API_KEY") }
	}
	
	func feachData() {
		guard let apiKey = apiKey else { return }
		
//		let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(apiKey)"
		let urlString = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=\(apiKey)"
		
		guard let url = URL(string: urlString) else { return }
		
		let session = URLSession(configuration: .default)
		
		let task = session.dataTask(with: url) { data, response, error in
			if let error = error {
				print(error.localizedDescription)
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				// 정상적으로 값이 오지 않았을 때 처리
				self.posts = []
				return
			}
			
			guard let data = data else {
				print("No data received")
				return
			}
			
//            let str = String(decoding: data, as: UTF8.self)
//            print(str)
			do {
				let json = try JSONDecoder().decode(Current.self, from: data)
				print(json.weather.count)
				DispatchQueue.main.async {
					self.current = json
					self.posts = json.weather
				}
			} catch let error {
				print(error.localizedDescription)
			}

		}
		task.resume()
	}

}
