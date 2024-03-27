//
//  Product.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/4/24.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class ProductStore: ObservableObject {
	static let shared = ProductStore()
	
	init() { }
	
	@Published var products = [Product]()
	
	// Realtime Database의 기본 경로를 저장하는 변수
	let ref: DatabaseReference? = Database.database().reference()
	
	// Realtime Database의 데이터 구조는 기본적으로 JSON 형태
	// 저장소와 데이터를 주고받을 때 JSON 형식의 데이터로 주고받기 때문에 Encoder, Decoder
	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()
	
	// 데이터베이스를 실시간으로 관찰하여 데이터 변경 여부를 확인
	// 실시간 데이터 읽기 쓰기가 가능
	func startListening() {
		guard let dbPath = ref?.child("products") else { return }
		
		dbPath.observe(DataEventType.childAdded) { [weak self] snapshot in
			guard let self = self, let json = snapshot.value as? [String: Any] else { return }
			do {
				let data = try JSONSerialization.data(withJSONObject: json)
				let product = try self.decoder.decode(Product.self, from: data)
				self.products.append(product)
				self.products.sort(by: { $0.name < $1.name })
			} catch {
				print(error)
			}
		}
		
		// 데이터 삭제가 감지 되었을 때
		dbPath.observe(DataEventType.childRemoved) { [weak self] snapshot in
			guard let self = self, let json = snapshot.value as? [String: Any] else { return }
			do {
				let data = try JSONSerialization.data(withJSONObject: json)
				let product = try self.decoder.decode(Product.self, from: data)
				for (index, item) in self.products.enumerated() where product.id == item.id {
					self.products.remove(at: index)
				}
			} catch {
				print(error)
			}
		}
		
		// 데이터 수정이 감지 되었을 때
		dbPath.observe(DataEventType.childChanged) { [weak self] snapshot in
			guard let self = self, let json = snapshot.value as? [String: Any] else { return }
			do {
				let data = try JSONSerialization.data(withJSONObject: json)
				let product = try self.decoder.decode(Product.self, from: data)
				for (index, item) in self.products.enumerated() where product.id == item.id {
					self.products[index] = product
				}
				self.products.sort(by: { $0.name < $1.name })
			} catch {
				print(error)
			}
		}
	}
	
	// 데이터베이스를 실시간 관찰하는 것을 중지
	func stopListening() {
		ref?.removeAllObservers()
	}
	
	// 데이터베이스에 Product 인스턴스를 추가
	func addProduct(item: Product) {
		self.ref?.child("products").child(item.id).setValue([
			"id": item.id,
			"name": item.name,
			"description" : item.description,
			"isOrder": item.isOrder
		])
	}
	
	// 데이터베이스에서 특정 경로의 데이터를 삭제
	func deleteProduct(key: String) {
		ref?.child("products/\(key)").removeValue()
	}
	
	// 데이터베이스에서 특정 데이터를 수정
	func editProduct(item: Product) {
		let update: [String: Any] = [
			"id": item.id,
			"name": item.name,
			"description" : item.description,
			"isOrder": item.isOrder
		]
		
		let childItem = ["products/\(item.id)": update]
//		for (index, product) in self.products.enumerated() where product.id == item.id {
//			products[index] = item
//		}
		self.ref?.updateChildValues(childItem)
	}
}

struct Product: Codable, Identifiable, Hashable {
	var id: String
	var name: String
	var description: String
	var isOrder: Bool
}
