//
//  ConcurrencyView3.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/19/23.
//

import SwiftUI

struct ConcurrencyView3: View {
	var body: some View {
		Button(action: {
			// 동기 함수에서 비동기 함수 호출
			Task {
				await doSomething()
			}
		}, label: {
			Text("Do Something")
		})
	}
	
	// async-let 바인딩
	// 비동기 함수를 호출하고 주변의 코드와 병렬로 실행하려면 (동시실행)
	// 상수를 정의할 때 let 앞에 async 를 작성하고, 상수를 사용할 때마다 await 를 작성
	func doSomething() async {
		print("Start \(Date())")
		async let result1 = takeTooLong()
		async let result2 = takeTooLong()
		async let result3 = takeTooLong()
		print("After async-let \(Date())")
		for i in 1...5 { print(i) }
		
		print("result1 End \(await result1)")
		print("result2 End \(await result2)")
		print("result3 End \(await result3)")
		// 비동기 함수와 동시에 실행할 추가 코드
		for i in 6...10 { print(i) }
		
	}
	
	func takeTooLong() async -> Date {
		sleep(UInt32.random(in: 1...5))            // 램덤 초 지연
		return Date()
	}
}

#Preview {
	ConcurrencyView3()
}
