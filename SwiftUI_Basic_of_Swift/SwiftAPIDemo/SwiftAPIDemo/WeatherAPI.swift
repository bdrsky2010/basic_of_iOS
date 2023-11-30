//
//  WeatherAPI.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct Current: Decodable {
	let weather: [Weather]
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
	
	
	private var apiKey: String? {
		get {
			let keyfilename = "ApiKeys"
			let api_key = "WEATHER_API_KEY"
			
			// 생성한 .plist 파일 경로 불러오기
			guard let filePath = Bundle.main.path(forResource: keyfilename, ofType: "plist") else {
				fatalError("Couldn't find file '\(keyfilename).plist'")
			}
			
			// .plist 파일 내용을 딕셔너리로 받아오기
			let plist = NSDictionary(contentsOfFile: filePath)
			
			// 딕셔너리에서 키 찾기
			guard let value = plist?.object(forKey: api_key) as? String else {
				fatalError("Couldn't find key '\(api_key)'")
			}
			
			return value
		}
	}
	
	func feachData() {
		guard let apiKey = apiKey else { return }
		
		let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(apiKey)"
		
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
					self.posts = json.weather
				}
			} catch let error {
				print("2")
				print(error.localizedDescription)
			}

		}
		task.resume()
	}

}
