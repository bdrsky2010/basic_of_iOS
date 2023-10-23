import Foundation

/*
 액터(Actors) p.249

 동시적으로 실행 되어야 할 프로그램 코드(조각)으로 분리하기 위해 Task(작업)를 사용

 작업들 끼리 서로 분리되어서 다른 작업 공간에서 안전하게 실해이 되지만, 작업 간에 일부 정보를 공유하려고 하면 문제 발생 가능(동시접근, 데이터 경쟁)

 액터를 사용하면 동시성 코드간에 정보를 안전하게 공유할 수 있음

 클래스와 마찬가지로 액터는 참조 타입
 클래스와 차이는 액터는 한 번에 하나의 작업만 변경 가능한 상태를 제공
 클래스를 액터로 만들려면 타입 선언에 'class'에서 'actor'로 변경
 */

/*
 class BuildMessage {

		 var message: String = ""
		 let greeting = "hello"

		 func setName(name: String) {
				 self.message = "\(greeting) \(name)"
		 }
 }
 */
// 클래스를 액터로 만들려면 타입 선언에 'class'에서 'actor'로 변경
/*
 actor BuildMessage {

		 var message: String = ""
		 let greeting = "hello"

		 func setName(name: String) {
				 self.message = "\(greeting) \(name)"
		 }
 }

 func someFunction() async {
		 let builder = BuildMessage()
		 await builder.setName(name: "Park")
		 let message = await builder.message
		 print(message)
 }

 Task {
		 await someFunction()
 }
 */

// 데이터 격리 이해하기
// 격리
actor BuildMessage {
	
	var message: String = ""
	let greeting = "hello"
	
	func setName(name: String) {
		self.message = "\(greeting) \(name)"
	}
	
	// 격리에서 제외
	nonisolated func getGreeting() -> String {
		return greeting
	}
}

func someFunction() async {
	let builder = BuildMessage()
	await builder.setName(name: "Park")
	let message = await builder.message
	print(message)
	print("someFunction:", builder.getGreeting() )
}

Task {
	await someFunction()
}
func syncFunction() {
	let builder = BuildMessage()
	print("syncFunction", builder.getGreeting() )
}

syncFunction()

// MainActor 소개 p.254
/*
 @MainActor
 class Timestore {
	 var timeStamps: [Int: Date] = [:]
	 
	 func addStamp(task: Int, date: Date) {
		 timeStamps[task] = date
	 }
 }
 */

class Timestore {
	@MainActor var timeStamps: [Int: Date] = [:]
	
	@MainActor func addStamp(task: Int, date: Date) {
		timeStamps[task] = date
	}
}

/*
 액터 예제 02
 actor 를 사용하여 비동기적으로 두 개의 숫자를 곱하는 함수를 가지고 있는 액터를 만들어 보세요.
 */
actor Multiplier {
	private var factor: Int
	init(factor: Int) {
		self.factor = factor
	}
	
	func multiple(_ input: Int) -> Int {
		return factor * input
	}
}

let multiplier = Multiplier(factor: 2)
Task {
	let result = await multiplier.multiple(4)
	print(result)
}

/*
 액터 예제 03
 다음 코드에서 actor 를 사용하여 Counter 클래스를 정의하고, increment 메서드를 구현하세요.

 (increment 메서드는 내부의 count 프로퍼티를 1 증가시킨다.)
 */
actor Counter {
	var counter = 0
	
	func increment() {
		self.counter += 1
	}
}

Task {
	let counter: Counter = Counter()
	await counter.increment()
	await counter.increment()
	await counter.increment()
	await counter.increment()
	print(await counter.counter)
}

/*
 액터 예제 04
 actor 를 사용하여 비동기적으로 두 개의 문자열을 연결하는 함수를 정의하고 호출하는 액터를 작성하세요.
 */
actor Concatenator {
	func concatenate(_ first: String, _ second: String) -> String {
		return first + second
	}
}

let concatenator: Concatenator = Concatenator()
Task {
	let result: String = await concatenator.concatenate("Cereal", "NyamNyam")
	print(result)
}

/*
 다음 기능들을 갖는 StringEx 액터를 정의하세요.

 비동기적으로 문자열을 대문자로 변환하는 함수를 정의
 비동기적으로 문자열을 소문자로 변환하는 함수를 정의
 비동기적으로 문자열을 역순으로 변환하는 함수를 정의
 */

actor StringEX {
	private var str: String
	init(str: String) { self.str = str }
	
	func capitalize() -> String { str.uppercased() }
	
	func lowercase() -> String { str.lowercased() }
	
	func reverse() -> String { String(str.reversed()) }
}

let str = StringEX(str: "swIFt")
Task {
	print(await str.capitalize())
	print(await str.lowercase())
	print(await str.reverse())
}

actor BankAccount {
	private var balance: Int = 0
	
	func deposit(money: Int) {
		self.balance += money
	}
	
	func withdraw(money: Int) {
		guard (balance - money) >= 0 else {
			print("Error: 잔고 부족")
			return
		}
		self.balance -= money
	}
	
	func showBalance() {
		print(balance)
	}
}

let account = BankAccount()

Task {
	await account.deposit(money: 1000)
	await account.withdraw(money: 500)
	await account.showBalance()
}

Task {
	await account.deposit(money: 3000)
	await account.withdraw(money: 6000)
	await account.showBalance()
}
