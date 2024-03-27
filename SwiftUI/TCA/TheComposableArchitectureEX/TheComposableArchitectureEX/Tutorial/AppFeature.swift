//
//  AppFeature.swift
//  TheComposableArchitectureEX
//
//  Created by Minjae Kim on 3/23/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppFeature {
	struct State: Equatable {
		var tab1 = CounterFeature.State()
		var tab2 = CounterFeature.State()
	}
	
	enum Action {
		case tab1(CounterFeature.Action)
		case tab2(CounterFeature.Action)
	}
	
	var body: some ReducerOf<Self> {
		Scope(state: \.tab1, action: \.tab1) {
			CounterFeature()
		}
		Scope(state: \.tab2, action: \.tab2) {
			CounterFeature()
		}
		
		Reduce { state, action in
			return .none
		}
	}
}

struct AppView: View {
//	let store1: StoreOf<CounterFeature>
//	let store2: StoreOf<CounterFeature>
	let store: StoreOf<AppFeature>
	
    var body: some View {
		// 상위 저장소에 있는 하위 저장소에 접근할 떄는 store.scope(state: , action: ) 메서드 사용
		TabView {
			CounterView(store: store.scope(state: \.tab1, action: \.tab1))
				.tabItem {
					Text("Counter 1")
				}
			
			CounterView(store: store.scope(state: \.tab2, action: \.tab2))
				.tabItem {
					Text("Counter 1")
				}
		}
    }
}

#Preview {
	AppView(
		store: Store(initialState: AppFeature.State()) {
			AppFeature()
		}
	)
}
