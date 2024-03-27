//
//  ProductViewModel.swift
//  CoreDataDemo2
//
//  Created by Minjae Kim on 12/27/23.
//

import Foundation
import CoreData

class ProductViewModel: ObservableObject {
	static let shared = ProductViewModel()
	
	let container: NSPersistentContainer
	@Published var products = [Product]()
	
	init() {
		self.container = PersistenceController.shared.container
		fetchProduct()
	}
	
	func fetchProduct() {
		let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
		
		do {
			self.products = try container.viewContext.fetch(fetchRequest)
		} catch {
			print("Error : fetchProduct init")
			print(error.localizedDescription)
		}
	}
	
	// 제품 추가
	func addProduct(name: String, quantity: String) {
		let product = Product(context: container.viewContext)
		product.name = name
		product.quantity = quantity
		
		saveContext()
	}
	
	// 제품 저장하기
	// viewContext를 영구 저장소에 저장
	// 데이터를 저장하면, 최신 데이터를 가져와서 products 데이터 변수에 할당
	// List 뷰가 최신 데이터로 업데이트 (addProduct() 함수 내에서 withAnimation에 배치)
	func saveContext() {
		do {
			try container.viewContext.save()
			
			// 변경 저장 후 다시 불러오기
			fetchProduct()
		} catch {
			let error = error as NSError
			fatalError("An error occurred \(error)")
		}
	}
	
	// 제품 삭제
	// offsets: 선택한 항목의 위치를 나타내는 List 항목의 오프셋 세트가 전달
	// saveContext() 항목이 삭제되면 변경사항을 영구 저장소에 저장
	func deleteProduct(offsets: IndexSet) {
		guard let index = offsets.first else { return }
		let entity = products[index]
		container.viewContext.delete(entity)
//			offsets.map { products[$0] }.forEach(contatainer.viewContext.delete)
		saveContext()
	}
}
