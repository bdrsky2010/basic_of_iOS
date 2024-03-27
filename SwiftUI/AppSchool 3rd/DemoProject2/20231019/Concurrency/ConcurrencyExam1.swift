//
//  ConcurrencyExam1.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/19/23.
//

import SwiftUI

struct ConcurrencyExam1: View {
	@State private var inputNum1: Int?
	@State private var inputNum2: Int?
	@State private var num1: Int = 0
	@State private var num2: Int = 0
	@State private var result: String = ""
	@State private var message: String = ""
	@State private var showingAlert = false
	var body: some View {
		VStack {
			VStack {
				TextField("첫 번째 숫자", value: $inputNum1, format: .number)
					.textFieldStyle(.roundedBorder)
					.keyboardType(.decimalPad)
					.onChange(of: inputNum1) { newValue in
						self.num1 = min(inputNum1 ?? 0, inputNum2 ?? 0)
						self.num2 = max(inputNum1 ?? 0, inputNum2 ?? 0)
					}
				TextField("두 번째 숫자", value: $inputNum2, format: .number)
					.textFieldStyle(.roundedBorder)
					.keyboardType(.decimalPad)
					.onChange(of: inputNum2) { newValue in
						self.num1 = min(inputNum1 ?? 0, inputNum2 ?? 0)
						self.num2 = max(inputNum1 ?? 0, inputNum2 ?? 0)
					}
			}
			.padding(.horizontal, 10)
			Button(action: {
				guard inputNum1 != nil, inputNum2 != nil else {
					self.message = "Input Error"
					showingAlert.toggle()
					return
				}
				// 동기 함수에서 비동기 함수 호출
				Task {
					do {
						self.result = "결과값 : " + (try await sum(num1, num2))
					} catch InputNumberError.bothInputZero {
						self.message = "Both Input Value is Zero"
						showingAlert.toggle()
					} catch InputNumberError.sameInput {
						self.message = "Same Input Value"
						showingAlert.toggle()
					} catch {
						self.message = "Unknown Error"
						showingAlert.toggle()
					}
				}
			}, label: {
				Text("Do Something")
			})
			.buttonStyle(.borderedProminent)
			.alert(message, isPresented: $showingAlert) {
				Button("OK", role: .cancel) {
					self.inputNum1 = nil
					self.inputNum2 = nil
				}
			}
			
			Text(result)
				.frame(maxWidth: .infinity)
		}
	}
	
	// 비동기 함수 선언 async
	// 비동기 함수 호출 await
	func sum(_ start: Int, _ end: Int) async throws -> String {
		guard start != 0 || end != 0 else { throw InputNumberError.bothInputZero }
		guard start != end else { throw InputNumberError.sameInput }
		async let a = sumFrom(start, end / 2)
		async let b = sumFrom(end / 2 + 1, end)
		return String((await a) + (await b))
	}

	func sumFrom(_ start: Int, _ end: Int) async -> Int {
		return (start...end).reduce(0, +)
	}
}

#Preview {
    ConcurrencyExam1()
}
