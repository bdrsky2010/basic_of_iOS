//
//  ContentView.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/4/24.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var productStore = ProductStore.shared
	@State var name: String = ""
	@State var description: String = ""
	@State var isOrder: Bool = false
	@State var path = NavigationPath()
	
	var body: some View {
		NavigationStack(path: $path) {
			VStack {
				TextField("name", text: $name)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				TextField("description", text: $description)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				Button {
					productStore.addProduct(item:
												Product(
													id: UUID().uuidString,
													name: name,
													description: description,
													isOrder: isOrder))
				} label: {
					Text("Add Product")
				}
				
				Spacer()
				
				List {
					ForEach(productStore.products, id: \.self) { product in
						NavigationLink(value: product) {
							HStack {
								Text(product.name)
								Spacer()
								Text(product.description)
							}
						}
					}
					.onDelete(perform: { indexSet in
						for index in indexSet {
							self.productStore.deleteProduct(key: productStore.products[index].id)
						}
					})
				}
			}
			.navigationDestination(for: Product.self) { product in
				EditView(product: product, path: $path)
					.environmentObject(productStore)
			}
		}
		.padding()
		.onAppear {
			self.productStore.startListening()
		}
		.onDisappear {
			self.productStore.stopListening()
		}
	}
}

#Preview {
	ContentView()
}
