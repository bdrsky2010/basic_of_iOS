//
//  CounterFeature.swift
//  TheComposableArchitectureEX
//
//  Created by Minjae Kim on 3/15/24.
//

/**
 컴포저블 아키텍쳐는 값의 반환과 복잡한 로직을 분리
 복잡한 로직을 호출할 때는 Effect를 사용
 Effect를 사용하는 방법은
 .run이라는 비동기를 처리해주는 핸들을 사용
 */
import ComposableArchitecture
import SwiftUI

// Reducer 도메인 모델링
@Reducer
struct CounterFeature {
	// 기능을 관찰하기 위한 ObservableState 매크로
	@ObservableState
	struct State: Equatable {
		var count = 0
		var fact: String?
		var isLoading = false
		var isTimerRunning = false
	}
	
	// 기능에서 사용되는 동작을 수행하는 작업을 보유하는 열거형
	enum Action {
		case decrementButtonTapped
		case factButtonTapped
		case factResponse(String)
		case incrementButtonTapped
		case timerTick
		case toggleTimerButtonTapped
	}
	
	enum CancelID { case timer }
	
	@Dependency(\.continuousClock) var clock
	@Dependency(\.numberFact) var numberFact
	
	// Reducer는 작업을 Reducer 내부에 body 속성에 나열해야한다
	// 더 이상 실행할 동작없이 값만 반환하는 경우 none을 return
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .decrementButtonTapped:
				state.count -= 1
				state.fact = nil
				return .none
				
			case .factButtonTapped:
				state.fact = nil
				state.isLoading = true
				return .run { [count = state.count] send in
					try await send(.factResponse(self.numberFact.fetch(count)))
				}
				
			case let .factResponse(fact):
				state.fact = fact
				state.isLoading = false
				return .none
				
			case .incrementButtonTapped:
				state.count += 1
				state.fact = nil
				return .none
				
			case .timerTick:
				state.count += 1
				state.fact = nil
				return .none
				
			// Effect를 취소하기 위해서는
			// .cancellable(id: )
			// .cancel(id: CancelID.timer) 을 사용
			case .toggleTimerButtonTapped:
				state.isTimerRunning.toggle()
				if state.isTimerRunning {
					return .run { send in
						while true {
							try await Task.sleep(for: .seconds(1))
							await send(.timerTick)
						}
					}
					.cancellable(id: CancelID.timer)
				} else {
					return .cancel(id: CancelID.timer)
				}
			}
		}
	}
}

struct CounterView: View {
	// 상태를 업데이트하기위해 작업을 처리하는 객체
	// ObservableState를 통해 자동적으로 관찰이 가능
	// 작업을 보낼 때는 store.send(_: )
	let store: StoreOf<CounterFeature>
	
	var body: some View {
		VStack {
			Text("\(store.count)")
				.font(.largeTitle)
				.padding()
				.background(Color.black.opacity(0.1))
				.cornerRadius(10)
			HStack {
				Button("-") {
					store.send(.decrementButtonTapped)
				}
				.font(.largeTitle)
				.padding()
				.background(Color.black.opacity(0.1))
				.cornerRadius(10)
				
				Button("+") {
					store.send(.incrementButtonTapped)
				}
				.font(.largeTitle)
				.padding()
				.background(Color.black.opacity(0.1))
				.cornerRadius(10)
			}
			Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
					store.send(.toggleTimerButtonTapped)
				  }
				  .font(.largeTitle)
				  .padding()
				  .background(Color.black.opacity(0.1))
				  .cornerRadius(10)
			
			Button("Fact") {
					store.send(.factButtonTapped)
				  }
				  .font(.largeTitle)
				  .padding()
				  .background(Color.black.opacity(0.1))
				  .cornerRadius(10)
			
			if store.isLoading {
					ProgressView()
				  } else if let fact = store.fact {
					Text(fact)
					  .font(.largeTitle)
					  .multilineTextAlignment(.center)
					  .padding()
				  }
		}
	}
}

#Preview {
	CounterView(
		store: Store(initialState: CounterFeature.State()) {
			CounterFeature()
		}
	)
}
