//
//  ViewModel.swift
//  CSVReadTest
//
//  Created by Minjae Kim on 1/22/24.
//

import Foundation

class ViewModel: ObservableObject {
//	@Published var beers = [Beer]()
	@Published var beers: [String] = []
	
	func parseCSVAt(url: URL) {
		do {
			let data = try Data(contentsOf: url)
			let dataEncoded = String(data: data, encoding: .utf8)
			if let dataArr = dataEncoded?.components(separatedBy: "\n") {
				for item in dataArr {
					beers.append(item)
				}
			} else {
				print("aaa")
			}
			print(beers)
		} catch {
			print("Error reading CSV file")
		}
	}
	
	func loadBeerFromCSV() {
		if let path = Bundle.main.path(forResource: "beer", ofType: "csv") {
			print(path)
			parseCSVAt(url: URL(filePath: path))
		}
	}
	
	func convertCSVtoJSON() {
		// CSV 파일의 경로
		guard let csvFilePath = Bundle.main.path(forResource: "beer", ofType: "csv") else {
			print("CSV 파일을 찾을 수 없습니다.")
			return
		}

		do {
			// CSV 파일 내용을 문자열로 읽기
			let csvContent = try String(contentsOfFile: csvFilePath, encoding: .utf8)

			// CSV 문자열을 줄 단위로 분할
			let csvLines = csvContent.components(separatedBy: "\n")

			// JSON 객체를 저장할 배열
			var jsonArray: [[String: String]] = []

			// CSV 헤더 추출
			guard let headers = csvLines.first?.components(separatedBy: ",") else {
				print("CSV 헤더를 찾을 수 없습니다.")
				return
			}

			var isInQuotes = false
			var currentValue = ""
			
			// CSV 데이터 처리
			for line in csvLines.dropFirst() {
				var values: [String] = []
				
	//            var isInQuotes = false
	//            var currentValue = ""
				
				// 큰따옴표 내에 쉼표가 포함된 경우를 고려하여 처리
				for char in line {
					if char == "\"" {
						isInQuotes.toggle()
					} else if char == "," && !isInQuotes {
						values.append(currentValue)
						currentValue = ""
					} else {
						currentValue.append(char)
					}
				}
				
				values.append(currentValue)

				// 각 행을 딕셔너리로 매핑
				var jsonDict: [String: String] = [:]
				
				for (index, value) in values.enumerated() {
					// 헤더 배열의 크기보다 작을 때만 처리
					if index < headers.count {
						let header = headers[index]
						jsonDict[header] = value
					}
				}

				jsonArray.append(jsonDict)
			}

			// JSON 데이터로 변환
			let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)

			// JSON 데이터를 문자열로 변환
			if let jsonString = String(data: jsonData, encoding: .utf8) {
				print(jsonString)
			}

		} catch {
			print("CSV 파일을 읽거나 JSON으로 변환하는 동안 오류가 발생했습니다: \(error)")
		}
	}
}
