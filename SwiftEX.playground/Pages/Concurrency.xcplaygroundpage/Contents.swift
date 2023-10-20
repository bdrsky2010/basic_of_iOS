/*
 # 스위프트 구조화된 동시성
 
 동시성
 - 여러 작업을 병렬로 수행하는 소프트웨어 기능
 - Swift는 구조화된 방식으로 비동기(asynchronous)와 병렬(parallel) 코드 작성을 지원
 - 비동기 코드는 일시적으로 중단되었다가 다시 실행할 수 있지만 한 번에 프로그램의 한 부분만 실행
 - 병렬 코드는 동시에 코드의 여러 부분이 실행됨을 의미
 - 동시성이라는 용어를 사용하여 비동기와 병렬 코드의 일반적인 조합을 나타냄
 
 스레드(thread)
 - 메인 프로세스 내에서 실행되는 미니 프로세스로 생각할 수 이씅며, 그 목적은 애플리케이션 코드 내에서 병렬 실행의 형태를 가능하게 하는 것
 - Swift에서 동시성 모델은 스레드의 최상단에 구축되지만 직접적으로 상호작용할 필요는 없음(구조화된 동시성이 모든 복잡성을 처리)
 
 애플리케이션 메인 스레드
 - 앱이 시작될 때 기본적으로 실행되는 단일 스레드
 - 주요 역할 : UI 레이아웃 렌더링, 이벤트 처리 및 사용자 인터페이스에서 부와 사용자 상호작용 측면에서 사용자 인터페이스를 처리
 
 비동기 함수 정의와 호출 (async / await)
 - 함수 파라미터 뒤의 선언부에 async 키워드를 작성
 - 함수 또는 메서드가 값을 반환한다면 반환 화살표 (->) 전에 async를 작성
 - 비동기 메서드를 호출할 때 해당 메서드가 반환될 때까지 실행이 일시 중단
 - 중단될 가능성이 있는 지점을 표시하기 위해 호출 앞에 await을 작성
 - Task를 이용하여 동기 함수에서 비동기 함수 호출
 
 비동기 함수 병렬로 호출
 - 비동기 함수를 호출하고 주변의 코드와 병렬로 실행하려면 (동시실행)
 - 상수를 정의할 때 let 앞에 async 를 작성하고 상수를 사용할 때마다 await 를 작성
 - await 를 사용하여 결과를 사용할 수 있을 때까지 실행이 중지
 
 ## 작업과 작업 그룹 (Tasks and Task Groups)
 
 작업(task)은 프로그램의 일부로 비동기적으로 실행할 수 있는 작업 단위
 - 모든 비동기 코드는 어떠한 작업의 일부로 실행
 - 작업은 계층 구조로 정렬이 가능
 - 작업 그룹 (task group) 을 생성하고 해당 그룹에 하위 작업을 추가 가능
 - 작업과 작업 그룹 간의 명시적 관계 때문에 이 접근 방식을 구조적 동시성 또는 구조화된 동시성 이라고 함
 
 
 ## 구조화되지 않은 동시성 (Unstructured Concurrency)
 - 작업 그룹의 일부인 작업과 달리 구조화되지 않는 작업에는 상위 작업이 없음
 - 프로그램이 필요로 히는 방식으로 구조화되지 않은 작업을 관리할 수 있는 안전한 유연성이 있지만 정확성에 대한 책임도 있음
 - 구조화되지 되지 않은 작업을 생성하려면 Task.init(priority: , operation: ) 초기화 구문을 호출
 - 분리된 작업으로 알려진 현재 액터의 일부가 아닌 구조화 되지 않은 작업을 생성하려면 Task.detached(priority: , operation: ) 메서드를 호출
 */


import Foundation

// 동기 코드
// takeTooLong() 함수가 실행되는 동안 아무 것도 할 수 없음
func doSomething1() {
	print("Start \(Date())")
	takeTooLong1()
	print("End \(Date())")
}

func takeTooLong1() {
	sleep(5)            // 5초 지연
	print("Async task completed at \(Date())")
}

doSomething1()

// 비동기 함수 선언 async
// 비동기 함수 호출 await
func doSomething2() async {
	print("Start \(Date())")
	await takeTooLong2()
	print("End \(Date())")
}

func takeTooLong2() async {
	sleep(5)            // 5초 지연
	print("Async task completed at \(Date())")
}

Task {
	await doSomething2()
}

// async-let 바인딩
// 비동기 함수를 호출하고 주변의 코드와 병렬로 실행하려면 (동시실행)
// 상수를 정의할 때 let 앞에 async 를 작성하고, 상수를 사용할 때마다 await 를 작성
func doSomething3() async {
	print("Start \(Date())")
	async let result1 = takeTooLong3()
	async let result2 = takeTooLong3()
	async let result3 = takeTooLong3()
	print("After async-let \(Date())")
	for i in 1...5 { print(i, Date()) }
	
	print("result1 End \(await result1)")
	print("result2 End \(await result2)")
	print("result3 End \(await result3)")
	// 비동기 함수와 동시에 실행할 추가 코드
	for i in 6...10 { print(i, Date()) }
	
}

func takeTooLong3() async -> Date {
	sleep(UInt32.random(in: 1...5))            // 램덤 초 지연
	return Date()
}

Task {
	await doSomething3()
}

enum DurationError: Error {
	case tooShort, tooLong
}

// 오류 핸들링과 함께
func doSomething4() async {
		print("Start \(Date())")
		do {
				try await takeTooLong4(delay: 25)
		} catch DurationError.tooShort {
				print("Error: Duration too short")
		} catch DurationError.tooLong {
				print("Error: Duration too long")
		} catch {
				print("Unknown error")
		}

		print("End \(Date())")
}

func takeTooLong4(delay: UInt32) async throws {
		if delay < 5 {
				throw DurationError.tooShort
		} else if delay > 20 {
				throw DurationError.tooLong
		}

		sleep(delay)            // 초 지연
		print("Async task complated at \(Date())")
}

Task {
	await doSomething4()
}

// 작업 그룹
// 동적인 조건에 따라 여러 작업을 동시에 생성하고 실행해야 하는 상황
// withTaskGroup() 함수 이용
// addTask() 함수를 호출하여 각각의 새로운 작업을 추가
// cancelAll() 그룹의 모든 작업을 취하는 메서드
// isCancelled 작업 그룹이 이미 취소되었는지 여부를 확인하는 속성
// IsEmpty 작업 그룹 내에 작업이 남아 있는지 여부를 확인하는 속성
// 데이터 경쟁 피하기
// 동시에 데이터에 접근하는 여러 작업은 데이터 경쟁(Data Race) 조건이 발생할 위험이 있음
// 여러 작업이 동시에 동일한 데이터에 접근하려고 시도하면 데이터 오류가 발생
func doSomething5() async {
	var timeStamps: [Int:Date] = [:]
	
	print("Start \(Date())")
	
	// 반환 타입을 변경 : Void.selt -> (Int, Date)
	await withTaskGroup(of: (Int, Date).self) { group in
		for i in 1...5 {
			group.addTask {
				return (i, await takeTooLong5())
			}
		}
		
		// for-await 표현식을 사용하여 비동기적으로 반환되는 일련의 값을 루프
		// 동시 작업에서 반환되는 값의 수신을 기다려서 처리
		// 일련의 데이터가 AsyncSequence 프로토콜 준수가 필수 요구사항
		for await (task, data) in group {
			timeStamps[task] = data
		}
	}
	
	// 작업 그룹이 종료된 후 저장된 timeStamps 딕셔너리 항목을 출력
	for (task, data) in timeStamps {
		print("Task = \(task), Date = \(data)")
	}
	
	print("End \(Date())")
}

func takeTooLong5() async -> Date {
	sleep(5)            // 5초 지연
	return Date()
}

Task {
	await doSomething5()
}

// 동시성 예제 01
/*
 1부터 100까지의 합을 구하는 비동기 함수
 async let을 사용하여 두 개의 비동기 작업을 동시에 실행하고 결과를 합하여 출력하는 함수를 작성해보세요.
 
 1...100 더하는 함수

 1...50 더하는 함수 1개 작업을 실행
 51...100 더하는 함수 1개 작어블 실행

 두 결과를 더해서 1...100 합한 값을 출력하세요.
 */
func sum(_ start: Int, _ end: Int) async -> Int {
	async let a = sumFrom(start, end / 2)
	async let b = sumFrom(end / 2 + 1, end)
	return (await a) + (await b)
}

func sumFrom(_ start: Int, _ end: Int) async -> Int {
	return (start...end).reduce(0, +)
}

Task {
	print(await sum(1, 100))   // 5050?
}

// 동시성 예제 02
/*
 동시성 예제 01을 withTaskGroup 사용으로 변환해 보세요.
 */
func sum2(_ start: Int, _ end: Int) async -> Int {
	var totalSum: [Int: Int] = [:]
	let indexlist = [start, end]
	await withTaskGroup(of: (Int, Int).self) { group in
		for i in 0...1 {
			group.addTask {
				if i == 1 {
					return (i, await sumFrom(indexlist[0], indexlist[1] / 2))
				}
				return (i, await sumFrom(indexlist[1] / 2 + 1, indexlist[1]))
			}
			
			for await (task, data) in group {
				totalSum[task] = data
			}
		}
	}
	return totalSum.values.reduce(0, +)}

Task {
	print(await sum2(1, 100))   // 5050?
}

enum InputNumberError: Error {
	case bothInputZero, secondInputZero, sameInput ,lessThanSecond
}

func sum3(_ start: Int, _ end: Int) async throws -> Int {
	guard end != 0 else { throw InputNumberError.secondInputZero }
	guard start != 0 && end != 0 else { throw InputNumberError.bothInputZero }
	guard start != end else { throw InputNumberError.sameInput }
	guard start < end else { throw InputNumberError.lessThanSecond }
	
	var totalSum: [Int: Int] = [:]
	let indexlist = [start, end]
	await withTaskGroup(of: (Int, Int).self) { group in
		for i in 0...1 {
			group.addTask {
				if i == 0 {
					return (i, await sumFrom(indexlist[0], indexlist[1] / 2))
				}
				return (i, await sumFrom(indexlist[1] / 2 + 1, indexlist[1]))
			}
			
			for await (task, data) in group {
				totalSum[task] = data
			}
		}
	}
	return totalSum.values.reduce(0, +)
}


Task {
	do {
		print(try await sum3(1, 100))   // 5050?
	} catch InputNumberError.bothInputZero {
		print("ERROR :: bothInputZero")
	} catch InputNumberError.secondInputZero {
		print("ERROR :: secondInputZero")
	} catch InputNumberError.sameInput {
		print("ERROR :: sameInput")
	} catch InputNumberError.lessThanSecond {
		print("ERROR :: lessThanSecond")
	} catch {
		print("ERROR :: Unknown error")
	}
}

// 동시성 예제 03
/*
 비동기 함수를 호출하고 결과를 출력하는 코드를 작성해보세요.
 */
func asyncFunction() async -> Int {
	let random = Int.random(in: 1...10)
	return random
}

Task {
	print(await asyncFunction())
}

// 동시성 예제 04
/*
 다음 코드는 두 개의 비동기 함수를 호출하고, 그 결과를 더해서 출력하는 코드입니다.
 하지만 이 코드는 컴파일 에러가 발생합니다.
 에러의 원인과 해결 방법을 설명하고, 올바른 코드를 작성해보세요.
 
 <원래 코드>
 func asyncAdd(_ x: Int, _ y: Int) async -> Int {
		 return x + y
 }

 func asyncPrintSum(_ a: Int, _ b: Int) {
		 let sum = await asyncAdd(a, b)
		 print(sum)
 }
 
 <정답>
 asyncPrintSum 함수 안에서 async한 함수인 asyncAdd를 호출했으니 
 async한 함수를 호출한 함수에도 리턴타입 자리에 async 키워드를 붙여줘야한다
 */
func asyncAdd(_ x: Int, _ y: Int) async -> Int {
	return x + y
}

func asyncPrintSum(_ a: Int, _ b: Int) async {
	let sum = await asyncAdd(a, b)
	print(sum)
}
Task {
	await asyncPrintSum(4, 5)
}


// 동시성 예제 05
/*
 다음 코드는 비동기 함수 fetchUser(id:)를 호출하고, 그 결과를 print하는 코드입니다.
 이 코드에 에러가 있는지, 있다면 어디에 있는지 찾아보고, 없다면 출력 결과를 예상해보세요
 
 <원래 코드>
 func fetchUser(id: Int) async -> String {
		 // some network request
		 return "User \(id)"
 }

 func printUser(id: Int) {
		 let user = await fetchUser(id: id)
		 print(user)
 }
 
 <정답>
 에러가 있다.
 printUser 함수에서 async한 fetchUser함수를 호출하였기에 printUser함수에
 async를 주어 async한 함수다 라는 것을 명시해줘야 한다
 */
func fetchUser(id: Int) async -> String {
	// some network request
	return "User \(id)"
}

func printUser(id: Int) async {
	let user = await fetchUser(id: id)
	print(user)
}

Task {
	await printUser(id: 12)
}


// 동시성 예제 06
/*
 다음 코드는 비동기 함수를 호출하고, 그 결과를 동기적으로 반환하는 함수입니다.
 하지만 이 코드는 런타임 에러가 발생합니다.
 에러의 원인과 해결 방법을 설명하고, 올바른 코드를 작성해보세요.
 
 <원래 코드>
 func asyncDouble(_ x: Int) async -> Int {
		 return x * 2
 }

 func syncDouble(_ x: Int) -> Int {
		 return await asyncDouble(x)
 }
 
 <정답>
 이 문제도 async한 함수를 호출했으니 그 함수를 호출한 syncDouble함수에
 async를 주어 async한 함수다 라는 것을 명시해줘야 한다
 */
func asyncDouble(_ x: Int) async -> Int {
	return x * 2
}

func syncDouble(_ x: Int) async -> Int {
	return await asyncDouble(x)
}

Task {
	print(await syncDouble(20))
}

// 동시성 예제 07
/*
 다음 코드는 두 개의 비동기 함수를 호출하고, 그 결과를 더해서 출력하는 코드입니다.
 하지만, 이 코드는 오류가 발생합니다.
 왜 그런지 설명하고, 오류를 수정한 코드를 작성하세요. 
 
 <원래 코드>
 func asyncAdd(_ x: Int, _ y: Int) async -> Int {
		 return x + y
 }

 func asyncPrintSum() {
		 let a = await asyncAdd(10, 20)
		 let b = await asyncAdd(30, 40)
		 print(a + b)
 }

 asyncPrintSum()
 
 <정답>
 asyncPrintSum 함수는 async한 함수인 asyncAdd를 호출했기에
 async한 함수다라고 명시해줘야 하며
 마지막에 asyncPrintSum() 호출부분에서
 async한 함수들은 작업단위로 돌아가기 때문에 작업단위인
 Task 안에서 돌아가야 하며 async한 함수를 호출하기 때문에
 함수 앞에 await 키워드를 붙여줘야한다.
 */

func asyncAdd2(_ x: Int, _ y: Int) async -> Int {
	return x + y
}

func asyncPrintSum() async {
	let a = await asyncAdd2(10, 20)
	let b = await asyncAdd2(30, 40)
	print(a + b)
}

Task {
	await asyncPrintSum()
}
