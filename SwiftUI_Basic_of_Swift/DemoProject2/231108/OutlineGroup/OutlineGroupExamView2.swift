//
//  OutlineGroupExamView2.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/8/23.
//

import SwiftUI

struct MenuItem: Identifiable {
	let id: UUID = UUID()
	var name: String
	var price: Double?
	var subItems: [MenuItem]?
}

let menuItems: [MenuItem] = [
	MenuItem(name: "Burger"),
	MenuItem(name: "Pizza", subItems: [
		MenuItem(name: "Cheese"),
		MenuItem(name: "Pepperoni"),
		MenuItem(name: "Veggie")
	]),
	MenuItem(name: "Salad")
]

struct OutlineGroupExamView2: View {
	var body: some View {
		List {
			OutlineGroup(menuItems, children: \.subItems) { subItem in
				Text(subItem.name)
			}
		}
	}
}

#Preview {
	OutlineGroupExamView2()
}
