//
//  MidFcstinfoServiceAPI.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 12/4/23.
//

import Foundation

struct MidFcstInfoResults1: Decodable {
	let response: Response1
}

struct Response1: Decodable {
	let header: Header
}

struct Header: Decodable {
	let resultCode: String
	let resultMsg: String
}


struct MidFcstInfoResults: Decodable {
	let response: Response
}

struct Response: Decodable {
	let body: Body
}

struct Body: Decodable {
	let items: Items
	let pageNo: Int
	let numOfRows: Int
}

struct Items: Decodable {
	let item: [Item]
}

struct Item: Decodable, Hashable {
	let wfSv: String
}


class MidFcstInfoServiceAPI: ObservableObject {
	static let shared = MidFcstInfoServiceAPI()
	private init() { }
	@Published var posts = [Item]()
	@Published var resultMessage: String?


	private var apiKey: String? {
		get { getValueOfPlistFile("ApiKeys", "MIDFCSTINFO_SERVICE_KEY") }
	}


	func feachData() {
		guard let apiKey = apiKey else { return }

		let urlString = "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidFcst?serviceKey=\(apiKey)&pageNo=1&numOfRows=10&dataType=JSON&stnId=108&tmFc=202312040600"

		guard let url = URL(string: urlString) else { return }

		let session = URLSession(configuration: .default)

		let task = session.dataTask(with: url) { data, response, error in
			if let error = error {
				print(error.localizedDescription)
				return
			}

			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }

			guard let data = data else {
				print("No data received")
				return
			}

			let str = String(decoding: data, as: UTF8.self)
			print(str)
			do {
				let results1 = try JSONDecoder().decode(MidFcstInfoResults1.self, from: data)
				if results1.response.header.resultCode != "00" {
					DispatchQueue.main.async {
						self.resultMessage = results1.response.header.resultMsg
					}
				} else {
					let results = try JSONDecoder().decode(MidFcstInfoResults.self, from: data)
					DispatchQueue.main.async {
						self.posts = results.response.body.items.item
					}
				}
			} catch let error {
				print(error.localizedDescription)
			}

		}
		task.resume()
	}

}
