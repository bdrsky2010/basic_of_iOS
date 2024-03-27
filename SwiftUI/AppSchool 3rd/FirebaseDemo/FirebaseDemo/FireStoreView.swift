//
//  FireStoreView.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/5/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FireStoreView: View {
	@ObservedObject var restaurantStore = RestaurantStore.shared
	@State var name: String = ""
	@State var address: String = ""
	
    var body: some View {
		VStack {
			TextField("name", text: $name)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			TextField("description", text: $address)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			
			HStack {
				Button("Add") {
					// dateAdded 매개변수 생략
					restaurantStore.addRestaurant(restaurant:
													Restaurant(name: name, address: address)
					)
				}
				Button("Update") {
					restaurantStore.updateRestaurant(restaurantName: name, restaurantAddress: address)
				}
				Button("Delete") {
					restaurantStore.deleteRestaurant(restaurantName: name)
				}
			}
			
			Button {
				restaurantStore.fetchAllRestaurant()
			} label: {
				Text("Load")
			}
			
			List {
				ForEach(restaurantStore.restaurants, id: \.self) { restaurant in
					HStack {
						Text(restaurant.name)
						Spacer()
						Text(restaurant.address)
					}
				}
				.onDelete(perform: { indexSet in
					for index in indexSet {
						restaurantStore.deleteRestaurant(restaurantName: restaurantStore.restaurants[index].name)
					}
				})
			}
		}
		.padding()
		.onAppear {
			self.restaurantStore.startListening()
		}
		.onDisappear {
			self.restaurantStore.stopListening()
		}
    }
}

#Preview {
    FireStoreView()
}
