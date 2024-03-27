//
//  AppStorageNavigationSaveView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct AppStorageNavigationSaveView: View {
	@AppStorage("selectedItem") var selectedItem: String?
	let items = ["Apple", "Banana", "Cherry"]
	
	var body: some View {
		NavigationView {
			List(items, id: \.self) { item in
				NavigationLink(
					destination: Text(item),
					tag: item,
					selection: $selectedItem) {
						Text(item)
					}
			}
		}
	}
}

#Preview {
	AppStorageNavigationSaveView()
}
