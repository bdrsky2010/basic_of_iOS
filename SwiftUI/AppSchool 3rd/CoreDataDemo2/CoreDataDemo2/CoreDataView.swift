//
//  CoreDataView.swift
//  CoreDataDemo2
//
//  Created by Minjae Kim on 12/27/23.
//

import SwiftUI

struct CoreDataView: View {
	
	@StateObject private var viewModel = ProductViewModel.shared
	
	@State var name: String = ""
	@State var quantity: String = ""
	
	var body: some View {
		NavigationStack {
			VStack {
				TextField("Product name", text: $name)
				TextField("Product quantity", text: $quantity)
				
				HStack {
					Spacer()
					Button("Add") {
						viewModel.addProduct(name: self.name, quantity: self.quantity)
					}
					Spacer()
					NavigationLink(destination: ResultView(name: name, viewContext: viewModel.container.viewContext)) {
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
				ForEach(viewModel.products) { product in
					HStack {
						Text(product.name ?? "Not Found")
						Spacer()
						Text(product.quantity ?? "Not Found")
					}
				}
				.onDelete(perform: viewModel.deleteProduct)
			}
			.navigationTitle("Product Database")
		}
	}
}

//#Preview {
//    CoreDataView()
//}
