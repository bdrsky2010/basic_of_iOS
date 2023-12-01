//
//  NewsAPI.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 11/30/23.
//

import SwiftUI

struct Results: Decodable {
	let articles: [Atricle]
}

struct Atricle: Decodable, Hashable {
	let title: String
	let url: String
	let urlToImage: String?
}

class NewsAPI: ObservableObject {
	static let shared = NewsAPI()
	private init() { }
	@Published var posts = [Atricle]()
	
	
	private var apiKey: String? {
		get { getValueOfPlistFile("ApiKeys", "API_KEY") }
	}
	
	func feachData() {
		guard let apiKey = apiKey else { return }
		
		let urlString = "https://newsapi.org/v2/everything?q=Apple&from=2023-11-29&sortBy=popularity&apiKey=\(apiKey)"
		
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
				let json = try JSONDecoder().decode(Results.self, from: data)
				print(json.articles.count)
				DispatchQueue.main.async {
					self.posts = json.articles
				}
			} catch let error {
				print(error.localizedDescription)
			}

		}
		task.resume()
	}

}
