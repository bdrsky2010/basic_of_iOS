//
//  AppStorageBackupView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct AppStorageBackupView: View {
	
	@AppStorage("myTabViewIndex") var tabViewIndex: Int = 0
	
	var body: some View {
		TabView(selection: $tabViewIndex) {
			Text("FirstTab")
				.tabItem {
					Image(systemName: "1.square.fill")
					Text("First")
				}
				.tag(0)
			
			Text("SecondTab")
				.tabItem {
					Image(systemName: "2.square.fill")
					Text("Second")
				}
				.tag(1)
			
			Text("ThirdTab")
				.tabItem {
					Image(systemName: "3.square.fill")
					Text("Third")
				}
				.tag(2)
		}
	}
}

#Preview {
	AppStorageBackupView()
}
