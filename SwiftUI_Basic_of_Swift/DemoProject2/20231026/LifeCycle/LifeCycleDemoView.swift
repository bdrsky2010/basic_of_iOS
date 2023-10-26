//
//  LifeCycleDemoView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct LifeCycleDemoView: View {
    var body: some View {
			TabView {
				FirstTabView()
					.tabItem {
						Image(systemName: "01.circle")
						Text("first")
					}
				
				SecondTabView()
					.tabItem {
						Image(systemName: "02.circle")
						Text("second")
					}
			}
    }
}

#Preview {
    LifeCycleDemoView()
}
