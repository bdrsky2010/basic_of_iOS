import SwiftUI

struct ConcurrencyView1: View {
	var body: some View {
		Button(action: {
			doSomething()
		}, label: {
			Text("Do Something")
		})
	}
	
	// 동기 코드 p.232-233
	// takeTooLong() 함수가 실행되는 동안 아무 것도 할 수 없음
	func doSomething() {
		print("Start \(Date())")
		takeTooLong()
		print("End \(Date())")
	}
	
	func takeTooLong() {
		sleep(5)            // 5초 지연
		print("Async task completed at \(Date())")
	}
}

#Preview {
	ConcurrencyView1()
}
