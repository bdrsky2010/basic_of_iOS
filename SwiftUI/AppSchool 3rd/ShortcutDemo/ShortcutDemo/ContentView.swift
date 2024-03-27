//
//  ContentView.swift
//  ShortcutDemo
//
//  Created by Minjae Kim on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		TabView {
			PurchaseView()
				.tabItem {
					Image(systemName: "cart")
					Text("Buy")
				}
			
			HistoryView()
				.tabItem {
					Image(systemName: "clock")
					Text("History")
				}
		}
    }
}

#Preview {
    ContentView()
}
