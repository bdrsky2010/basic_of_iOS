          //
//  TheComposableArchitectureEXApp.swift
//  TheComposableArchitectureEX
//
//  Created by Minjae Kim on 3/15/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TheComposableArchitectureEXApp: App {
	// store는 앱이 구동되는 동안 한 번만 생성되어야 한다
	// 대부분의 앱에서는 scene의 root에서 생성
	static let store = Store(initialState: AppFeature.State()) {
		AppFeature()
			._printChanges() // 작업 처리 후 변경된 상태를 출력
	}
	
	var body: some Scene {
		WindowGroup {
			AppView(store: TheComposableArchitectureEXApp.store)
		}
	}
}
