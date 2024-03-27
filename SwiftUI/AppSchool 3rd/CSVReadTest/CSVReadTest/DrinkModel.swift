//
//  DrinkModel.swift
//  CSVReadTest
//
//  Created by Minjae Kim on 1/23/24.
//

import Foundation

enum StringOrInt: Codable {
	case integer(Int)
	case string(String)

	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let x = try? container.decode(Int.self) {
			self = .integer(x)
			return
		}
		if let x = try? container.decode(String.self) {
			self = .string(x)
			return
		}
		throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StringOrInt"))
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case .integer(let x):
			try container.encode(x)
		case .string(let x):
			try container.encode(x)
		}
	}
}

struct Beer: Codable {
	// beer_kor_name,image,beer_eng_name,class,country,description,score,aroma,appearance,flavor,mouthfeel,type
	let id = UUID()
	let name: String
	let imageURL: String
	let engName: String
	let currentClass: String
	let country: String
	let description: String
	let score: Double
	let aroma: Double
	let appearance: Double
	let flavor: Double
	let mouthfeel: Double
	let type: String
	
	enum CodingKeys: String, CodingKey {
		case name = "beer_kor_name"
		case imageURL = "image"
		case engName = "beer_eng_name"
		case currentClass = "class"
		case country, description, score, aroma, appearance, flavor, mouthfeel, type
	}
}

struct Cocktail: Codable {
	// Alcohol,Name,image,Category,Making,Base Wine,Base Wine Amount,Liquor,Liquor Amount,Juice,Juice Amount,Spice,Spice Amount,Soda,Soda Amount,Others,Taste,Type of Glass,Salty,Savory,Sour,Bitter,Sweet,Spicy
	let id = UUID()
	let alcohol: Int
	let name: String
	let image: String
	let category: String
	let making: String
	let baseWine: String
	let baseWineAmount: StringOrInt
	let liquor: String
	let liquorAmount: StringOrInt
	let juice: String
	let juiceAmount: StringOrInt
	let spice: String
	let spiceAmount: StringOrInt
	let soda: String
	let sodaAmount: StringOrInt
	let others: String
	let taste: String
	let typeOfGlass: String
	let salty: Int
	let savory: Int
	let sour: Int
	let bitter: Int
	let sweet: Int
	let spicy: Int
	
	enum CodingKeys: String, CodingKey {
		case alcohol = "Alcohol"
		case name = "Name"
		case image
		case category = "Category"
		case making = "Making"
		case baseWine = "Base Wine"
		case baseWineAmount = "Base Wine Amount"
		case liquor = "Liquor"
		case liquorAmount = "Liquor Amount"
		case juice = "Juice"
		case juiceAmount = "Juice Amount"
		case spice = "Spice"
		case spiceAmount = "Spice Amount"
		case soda = "Soda"
		case sodaAmount = "Soda Amount"
		case others = "Others"
		case taste = "Taste"
		case typeOfGlass = "Type of Glass"
		case salty = "Salty"
		case savory = "Savory"
		case sour = "Sour"
		case bitter = "Bitter"
		case sweet = "Sweet"
		case spicy = "Spicy"
	}
}

struct TraditionalLiquor: Codable {
	// 제품명,단맛,신맛,청량감,바디감,도수%,탄산,주종,용량,가격,제조사,원재료
	let id = UUID()
	let name: String
	let sweet: StringOrInt
	let sour: StringOrInt
	let fresh: StringOrInt
	let body: Int
	let alcohol: Double
	let soda: Int
	let type: String
	let amount: String
	let price: StringOrInt
	let manufacturer: String
	let material: String
	
	enum CodingKeys: String, CodingKey {
		case name = "제품명"
		case sweet = "단맛"
		case sour = "신맛"
		case fresh = "청량감"
		case body = "바디감"
		case alcohol = "도수%"
		case soda = "탄산"
		case type = "주종"
		case amount = "용량"
		case price = "가격"
		case manufacturer = "제조사"
		case material = "원재료"
	}
}

struct Whisky: Codable {
	// ,Whiskey,Meta Critic,STDEV,#,Cost,Class,Super Cluster,cluster,body,sweet,sherry,malt,aperitif,smoky,pungent,fruity,honey,floral,spicy,medicinal,nutty,winey,images,links
	let id = UUID()
	let index: Int
	let whiskey: String
	let metaCritic: Double
	let stdev: Double
	let num: Int
	let cost: String
	let style: String
	let superCluster: String
	let cluster: String
	let body: Double
	let sweet: Double
	let sherry: Double
	let malt: Int
	let aperitif: Double
	let smoky: Double
	let pungent: Double
	let fruity: Double
	let honey: Double
	let floral: Double
	let spicy: Double
	let medicinal: Double
	let nutty: Double
	let winey: Double
	let images: String
	let links: String
	
	enum CodingKeys: String, CodingKey {
		case index = ""
		case whiskey = "Whiskey"
		case metaCritic = "Meta Critic"
		case stdev = "STDEV"
		case num = "#"
		case cost = "Cost"
		case style = "Class"
		case superCluster = "Super Cluster"
		case cluster, body, sweet, sherry, malt, aperitif, smoky, pungent, fruity, honey, floral, spicy, medicinal, nutty, winey, images, links
	}
}

struct Wine: Codable {
	// title,image_link,winery,country,province,grape_type,wine_type,occasion,alcohol,sweetness,acidity,body_rate,tannin_rate,food_pairing,price,vintage,size,link,aroma
	let id = UUID()
	let empty: Int
	let title: String
	let imageLink: String
	let winery: String
	let country: String
	let province: String
//	let grapeType: String
	let wineType: String
	let occasion: String
	let alcohol: Double
	let sweetness, acidity, bodyRate, tanninRate: Int
	let foodPairing: String
	let price: Int
	let vintage: StringOrInt
	let size: Int
	let link: String
	let aroma: String
	
	enum CodingKeys: String, CodingKey {
		case empty = ""
		case title
		case imageLink = "image_link"
		case winery, country, province
//		case grapeType = "grape_type"
		case wineType = "wine_type"
		case occasion, alcohol, sweetness, acidity
		case bodyRate = "body_rate"
		case tanninRate = "tannin_rate"
		case foodPairing = "food_pairing"
		case price, vintage, size, link, aroma
	}
}
