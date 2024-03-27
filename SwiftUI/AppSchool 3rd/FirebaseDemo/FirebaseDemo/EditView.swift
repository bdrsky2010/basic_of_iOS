//
//  EditView.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/4/24.
//

import SwiftUI

struct EditView: View {
	@EnvironmentObject var productStore: ProductStore
	let product: Product
	@Binding var path: NavigationPath
	
	@State private var name: String = ""
	@State private var description: String = ""
	@State private var isOrder: Bool
	
	init(product: Product, path: Binding<NavigationPath>) {
		self.product = product
		self._path = path
		self._isOrder = State(initialValue: product.isOrder)
	}
	var body: some View {
		VStack {
			TextField("\(product.name)", text: $name)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			TextField("\(product.description)", text: $description)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			Toggle("isOrder", isOn: $isOrder)
			Button {
				tapEditButton()
			} label: {
				Text("Edit")
			}
		}
		.padding()
	}
	
	private func tapEditButton() {
		productStore.editProduct(
			item: Product(id: product.id,
						  name: name.isEmpty ? product.name : name,
						  description: description.isEmpty ? product.description : description,
						  isOrder: isOrder))
		path.removeLast()
	}
}
