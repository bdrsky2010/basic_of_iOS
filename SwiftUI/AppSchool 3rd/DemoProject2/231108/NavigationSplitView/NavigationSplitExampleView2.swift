//
//  NavigationSplitExampleView2.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/8/23.
//

import SwiftUI

enum Category: String {
	case Mac = "Mac"
	case iPad = "iPad"
	case iPhone = "iPhone"
	case Watch = "Watch"
	case AirPods = "AirPods"
}

struct Product: Hashable {
	var product: String
	var image: String
}

struct Apple: Identifiable, Hashable {
	let id = UUID()
	var title: Category
	var products: [Product] {
		switch title {
		case .Mac:
			return [
				Product(product: "MacBook M2 Air", image: "macbook"),
				Product(product: "MacBook M2 Pro", image: "macbook"),
				Product(product: "MacBook M2 Max", image: "macbook"),
				Product(product: "iMac", image: "desktopcomputer"),
				Product(product: "Mac mini", image: "macmini"),
				Product(product: "Mac Studio", image: "macmini"),
				Product(product: "Mac Pro", image: "macpro.gen3")
			]
		case .iPad:
			return [
				Product(product: "iPad Pro", image: "ipad.gen2.landscape"),
				Product(product: "iPad Air", image: "ipad.gen2.landscape"),
				Product(product: "iPad", image: "ipad.gen1"),
				Product(product: "iPad mini", image: "ipad.gen2.landscape")
			]
		case .iPhone:
			return [
				Product(product: "iPhone 15 Pro", image: "iphone.gen3"),
				Product(product: "iPhone 15", image: "iphone.gen3"),
				Product(product: "iPhone 14", image: "iphone.gen2"),
				Product(product: "iPhone 13", image: "iphone.gen2"),
				Product(product: "iPhone SE", image: "iphone.gen1")
			]
		case .Watch:
			return [
				Product(product: "Apple Watch Series 9", image: "applewatch"),
				Product(product: "Apple Watch Ultra 2", image: "applewatch"),
				Product(product: "Apple Watch Se", image: "applewatch"),
				Product(product: "Apple Watch Nike", image: "applewatch"),
				Product(product: "Apple Watch Hermes", image: "applewatch")
			]
		case .AirPods:
			return [
				Product(product: "AirPods 2nd Generation", image: "airpods"),
				Product(product: "AirPods 3rd Generation", image: "airpods.gen3"),
				Product(product: "AirPods Pro 2nd Generation", image: "airpodspro"),
				Product(product: "AirPods Max", image: "airpodsmax"),
			]
		}
	}
}

struct AppleListView: View {
	var apples: [Apple]
	@Binding var selectedItem: Apple?
	
	var body: some View {
		List(apples, id: \.self, selection: $selectedItem) { apple in
			Text(apple.title.rawValue).tag(apple)
		}
	}
}

struct CategoryContentView: View {
	var products: [Product]
	@Binding var selectedCategory: Product?
	
	var body: some View {
		List(products, id: \.self, selection: $selectedCategory) { product in
			Text(product.product).tag(product)
		}
	}
}

struct DetailView: View {
	let product: String
	let image: String
	
	var body: some View {
		VStack {
			Text(product)
				.multilineTextAlignment(.center)
			Image(systemName: image)
				.resizable()
				.aspectRatio(contentMode: .fit)
		}
		.padding()
	}
}

struct NavigationSplitExampleView2: View {
	@State private var apples = [
		Apple(title: .Mac),
		Apple(title: .iPad),
		Apple(title: .iPhone),
		Apple(title: .Watch),
		Apple(title: .AirPods)
	]
	
	@State private var selectedApple: Apple?
	@State private var selectedCategory: Product?
	@State private var columnsViibility = NavigationSplitViewVisibility.all
	
	var body: some View {
		NavigationSplitView(columnVisibility: $columnsViibility) {
			AppleListView(apples: apples, selectedItem: $selectedApple)
		} content: {
			if let selectedApple {
				CategoryContentView(products: selectedApple.products, selectedCategory: $selectedCategory)
			}
		} detail: {
			if let selectedCategory {
				DetailView(product: selectedCategory.product, image: selectedCategory.image)
			}
		}
		.navigationSplitViewStyle(.balanced)
	}
}

#Preview {
	NavigationSplitExampleView2()
}
