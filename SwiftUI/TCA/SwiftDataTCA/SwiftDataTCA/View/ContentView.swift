//
//  ContentView.swift
//  SwiftDataTCA
//
//  Created by Minjae Kim on 3/29/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

@Reducer
struct ContentFeature {
	@ObservableState
	struct State {
		var memos: [Memo] = []
		var searchString: String = ""
		var fetchDescriptor: FetchDescriptor<Memo> {
			return .init(predicate: self.predicate, 
						 sortBy: [SortDescriptor<Memo>(\.timestamp, order: .forward)])
		}
		var predicate: Predicate<Memo> {
			guard !searchString.isEmpty 
			else { return #Predicate<Memo> { _ in true } }
			
			return #Predicate {
				$0.title.localizedStandardContains(searchString)	
			}
		}
		
		mutating
		func reFetchMemos() {
			@Dependency(\.swiftData) var context
			do {
				self.memos = try context.fetch(self.fetchDescriptor)
			} catch {}
		}
	}
	
	enum Action {
		case fetch
		case addButtonTapped
		case delete
		case searchStringChanged(String)
	}
	
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .fetch:
				state.reFetchMemos()
				return .none
				
			case .addButtonTapped:
				return .none
				
			case .delete:
				return .run { @MainActor send in
					send(.fetch, animation: .default)
				}
				
			case let .searchStringChanged(newString):
				guard newString != "" else { return .none }
				state.searchString = newString
				
				return .run { @MainActor send in
					send(.fetch, animation: .default)
				}
			}
		}
	}
}

struct ContentView: View {
	let store: StoreOf<ContentFeature>
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(store.memos) { memo in
					VStack(alignment: .leading) {
						Text(memo.title)
						
						HStack {
							Text("2024. 3.  29")
							Text(memo.content.isEmpty ? "추가 텍스트 없음" : memo.content)
						}
						.lineLimit(1)
					}
				}
			}
			.padding()
			.navigationTitle("Memo")
			.toolbar {
				ToolbarItemGroup(placement: .bottomBar) {
					Spacer()
					Text("\(store.memos.count)개의 메모")
					Spacer()
					Button {
						
					} label: {
						Image(systemName: "square.and.pencil")
					}
				}
			}
		}
    }
}

#Preview {
    ContentView(
		store: Store(initialState: ContentFeature.State()) {
			ContentFeature()
		}
	)
}
