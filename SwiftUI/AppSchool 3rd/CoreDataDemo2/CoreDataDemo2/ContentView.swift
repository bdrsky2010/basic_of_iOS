//
//  ContentView.swift
//  CoreDataDemo2
//
//  Created by Minjae Kim on 12/27/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
	
	@State var name: String = ""
	@State var quantity: String = ""
	
	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
		animation: .default)
	private var items: FetchedResults<Item>
	
	@FetchRequest(entity: Product.entity(),
				  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
	private var products: FetchedResults<Product>
	
	var body: some View {
		NavigationStack {
			VStack {
				TextField("Product name", text: $name)
				TextField("Product quantity", text: $quantity)
				
				HStack {
					Spacer()
					Button("Add") {
						addProduct()
					}
					Spacer()
					NavigationLink(destination: ResultView(name: name, viewContext: viewContext)) {
						Text("Find")
					}
					Spacer()
					Button("Clear") {
						name = ""
						quantity = ""
					}
					Spacer()
				}
				.padding()
				.frame(maxWidth: .infinity)
			}
			.padding()
			.textFieldStyle(RoundedBorderTextFieldStyle())
			
			List {
				ForEach(products) { product in
					HStack {
						Text(product.name ?? "Not Found")
						Spacer()
						Text(product.quantity ?? "Not Found")
					}
				}
				.onDelete(perform: deleteProduct)
			}
			.navigationTitle("Product Database")
		}
		
		NavigationView {
			List {
				ForEach(items) { item in
					NavigationLink {
						Text("Item at \(item.timestamp!, formatter: itemFormatter)")
					} label: {
						Text(item.timestamp!, formatter: itemFormatter)
					}
				}
				.onDelete(perform: deleteItems)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
				ToolbarItem {
					Button(action: addItem) {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
			Text("Select an item")
		}
		.frame(height: 200)
	}
	
	// 제품 추가
	private func addProduct() {
		withAnimation {
			let product = Product(context: viewContext)
			product.name = self.name
			product.quantity = self.quantity
			
			saveContext()
		}
	}
	
	// 제품 저장하기
	// viewContext를 영구 저장소에 저장
	// 데이터를 저장하면, 최신 데이터를 가져와서 products 데이터 변수에 할당
	// List 뷰가 최신 데이터로 업데이트 (addProduct() 함수 내에서 withAnimation에 배치)
	private func saveContext() {
		do {
			try viewContext.save()
		} catch {
			let error = error as NSError
			fatalError("An error occurred \(error)")
		}
	}
	
	private func addItem() {
		withAnimation {
			let newItem = Item(context: viewContext)
			newItem.timestamp = Date()
			
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
	
	// 제품 삭제
	// offsets: 선택한 항목의 위치를 나타내는 List 항목의 오프셋 세트가 전달
	// saveContext() 항목이 삭제되면 변경사항을 영구 저장소에 저장
	private func deleteProduct(offsets: IndexSet) {
		withAnimation {
			offsets.map { products[$0] }.forEach(viewContext.delete)
			saveContext()
		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map { items[$0] }.forEach(viewContext.delete)
			
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
}

// 검색 결과를 표시하는 화면
struct ResultView: View {
	var name: String
	var viewContext: NSManagedObjectContext
	
	// 제품의 검색 결과가 List에 표시될 상태 프로퍼티
	@State var matches: [Product]?
	var body: some View {
		VStack {
			List {
				ForEach(matches ?? []) { match in
					HStack {
						Text(match.name ?? "Not Found")
						Spacer()
						Text(match.quantity ?? "Not Found")
					}
				}
			}
			.navigationTitle("Result")
		}
		//
		.task {
			let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
			
			// Product 엔티티에서 검색 조건을 정의
			// CONTAINS 키워드: 검색에서 지정된 텍스트를 포함하는 모든 제품을 검색
			fetchRequest.entity = Product.entity()
			fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
			
			matches = try? viewContext.fetch(fetchRequest)
		}
	}
}

private let itemFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	formatter.timeStyle = .medium
	return formatter
}()

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
