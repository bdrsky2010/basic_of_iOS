//
//  StorageDemoView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct StorageDemoView: View {
	var body: some View {
		TabView {
			List {
				NavigationLink(destination: AppStorageColorPickerView()) {
					Text("AppStorageColorPicker")
				}
				NavigationLink(destination: AppStorageBackupView()) {
					Text("AppStorageBackupView")
				}
				NavigationLink(destination: SceneStorageNameSaveView()) {
					Text("SceneStorageNameSaveView")
				}
				NavigationLink(destination: AppStorageNavigationSaveView()) {
					Text("AppStorageNavigationSaveView")
				}
			}
			.tabItem {
				Image(systemName: "triangle.fill")
				Text("StorageExample")
			}
			SceneStorageView()
				.tabItem {
					Image(systemName: "circle.fill")
					Text("SceneStorage")
				}
			
			AppStorageView()
				.tabItem {
					Image(systemName: "square.fill")
					Text("AppStorage")
				}
		}
	}
}

#Preview {
	StorageDemoView()
}
