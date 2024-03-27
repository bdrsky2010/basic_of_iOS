//
//  DrinkViewModel.swift
//  CSVReadTest
//
//  Created by Minjae Kim on 1/23/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

enum DrinkType {
	case beer, cocktail, traditionalLiquor, whisky, wine
	
	var string: String {
		switch self {
		case .beer:
			return "beer"
		case .cocktail:
			return "cocktail"
		case .traditionalLiquor:
			return "traditional_liquor"
		case .whisky:
			return "whisky"
		case .wine:
			return "wine"
		}
	}
}

enum ProcessedDrinkType {
	case beer, cocktail, traditionalLiquor, whisky, wine
	
	var string: String {
		switch self {
		case .beer:
			return "processedBeer"
		case .cocktail:
			return "processedcocktail"
		case .traditionalLiquor:
			return "processedtraditional_liquor"
		case .whisky:
			return "processedwhisky"
		case .wine:
			return "processedwine"
		}
	}
}

class DrinkViewModel: ObservableObject {
	
	let db = Firestore.firestore()
	
	func jsonLoad(drinkType: DrinkType) -> Data? {
		guard let jsonLocation = Bundle.main.url(forResource: drinkType.string, withExtension: "json") else { return nil }
		
		do {
			let data = try Data(contentsOf: jsonLocation)
			return data
		} catch {
			return nil
		}
	}
	
	func jsonDataToString(drinkType: DrinkType) {
		guard
			let jsonData = jsonLoad(drinkType: drinkType),
			let stringData = String(data: jsonData, encoding: .utf8)
		else { return }
	}
	
	func decodeJson(drinkType: DrinkType) {
		guard let jsonData = jsonLoad(drinkType: drinkType) else { return }
		switch drinkType {
		case .beer:
			guard let drinkData = try? JSONDecoder().decode([ProcessedBeer].self, from: jsonData) else { return }
			saveJsonData(drinkType: drinkType, data: drinkData)
		case .cocktail:
			guard let drinkData = try? JSONDecoder().decode([ProcessedCocktail].self, from: jsonData) else { return }
			saveJsonData(drinkType: drinkType, data: drinkData)
		case .traditionalLiquor:
			guard let drinkData = try? JSONDecoder().decode([ProcessedTraditionalLiquor].self, from: jsonData) else { return }
			saveJsonData(drinkType: drinkType, data: drinkData)
		case .whisky:
			guard let drinkData = try? JSONDecoder().decode([ProcessedWhisky].self, from: jsonData) else { return }
			saveJsonData(drinkType: drinkType, data: drinkData)
		case .wine:
			guard let drinkData = try? JSONDecoder().decode([ProcessedWine].self, from: jsonData) else { return }
			saveJsonData(drinkType: drinkType, data: drinkData)
		}
	}
	
	func saveJsonData<T: Codable>(drinkType: DrinkType, data: [T]) {
		guard let data = try? JSONEncoder().encode(data) else { return }
		
		guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
		switch drinkType {
		case .beer:
			let fileURL = documentDirectoryURL.appendingPathComponent("prossesed_beer.json")
			do {
				try data.write(to: fileURL)
				let jsonData = try Data(contentsOf: fileURL)
				guard let drinkData = try? JSONDecoder().decode([ProcessedBeer].self, from: jsonData) else { return }
				print(drinkData)
			} catch let error {
				print(error)
			}
		case .cocktail:
			let fileURL = documentDirectoryURL.appendingPathComponent("prossesed_cocktail.json")
			do {
				try data.write(to: fileURL)
				let jsonData = try Data(contentsOf: fileURL)
				guard let drinkData = try? JSONDecoder().decode([ProcessedCocktail].self, from: jsonData) else { return }
				print(drinkData)
			} catch let error {
				print(error)
			}
		case .traditionalLiquor:
			let fileURL = documentDirectoryURL.appendingPathComponent("prossesed_traditional_liquor.json")
			do {
				try data.write(to: fileURL)
				let jsonData = try Data(contentsOf: fileURL)
				guard let drinkData = try? JSONDecoder().decode([ProcessedTraditionalLiquor].self, from: jsonData) else { return }
				print(drinkData)
			} catch let error {
				print(error)
			}
		case .whisky:
			let fileURL = documentDirectoryURL.appendingPathComponent("prossesed_whisky.json")
			do {
				try data.write(to: fileURL)
				let jsonData = try Data(contentsOf: fileURL)
				guard let drinkData = try? JSONDecoder().decode([ProcessedWhisky].self, from: jsonData) else { return }
				print(drinkData)
			} catch let error {
				print(error)
			}
		case .wine:
			let fileURL = documentDirectoryURL.appendingPathComponent("prossesed_wine.json")
			do {
				try data.write(to: fileURL)
				let jsonData = try Data(contentsOf: fileURL)
				guard let drinkData = try? JSONDecoder().decode([ProcessedWine].self, from: jsonData) else { return }
				print(drinkData)
			} catch let error {
				print(error)
			}
		}
	}
	
	func processedJsonLoad(drinkType: ProcessedDrinkType) -> Data? {
		guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(drinkType.string).json") else { return nil }
		print(fileURL)
		do {
			let data = try Data(contentsOf: fileURL)
			return data
		} catch {
			return nil
		}
	}
	
	func decodeProcessedJson(drinkType: ProcessedDrinkType) {
		guard let jsonData = processedJsonLoad(drinkType: drinkType) else { return }
		switch drinkType {
		case .beer:
			guard let drinkData = try? JSONDecoder().decode([ProcessedBeer].self, from: jsonData) else { return }
			print(drinkData)
		case .cocktail:
			guard let drinkData = try? JSONDecoder().decode([ProcessedCocktail].self, from: jsonData) else { return }
			print(drinkData)
		case .traditionalLiquor:
			guard let drinkData = try? JSONDecoder().decode([ProcessedTraditionalLiquor].self, from: jsonData) else { return }
			print(drinkData)
		case .whisky:
			guard let drinkData = try? JSONDecoder().decode([ProcessedWhisky].self, from: jsonData) else { return }
			print(drinkData)
		case .wine:
			guard let drinkData = try? JSONDecoder().decode([ProcessedWine].self, from: jsonData) else { return }
			print(drinkData)
		}
	}
}
