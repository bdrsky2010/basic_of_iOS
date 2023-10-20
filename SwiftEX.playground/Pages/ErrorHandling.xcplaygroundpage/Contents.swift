import Foundation

/*
 # 에러 핸들링 (Error Handling) 소개 p.133
 
 발생할 수 있는 모든 에러에 대해 처리
 - 원하는 결과가 나오지 않을 경우에 에러를 발생(스로잉 throwing)
 - 메서드가 던진(throwing) 에러를 잡아서(catch) 처리
 
 do-catch
 ```
 do {
		try [throw를 발생하는 함수()]
 } catch [에러패턴1] {
 } catch [에러패턴2] {
 } catch [에러패턴3] where [조건] {
 } catch [에러패턴4, 에러패턴5] {
 } catch { // default
 }
 ```
 
 defer 구문 p.138
 - 현재 코드블록이 종료되기 직전에(맨 마지막에) 수행되는 작업을 지정(예: 정리작업)
 */

// 에러 타입 선언하기 p.134
enum FileTransferError: Error {
	case noConnection
	case lowBandWidth
	case fileNotFound
}

// 에러 던지기(발생) p.135
let connectionOk: Bool = true
let connectionSpeed: Double = 30.00
let fileFound: Bool = false

func fileTransfer() throws -> Int {
	guard connectionOk else {
		throw FileTransferError.noConnection
	}
	
	guard connectionSpeed > 30 else {
		throw FileTransferError.lowBandWidth
	}
	
	guard fileFound else {
		throw FileTransferError.fileNotFound
	}
	
	// guard 구문에서 에러가 나지 않으면 아래 코드 수행
	return 1
}

// 스로잉 메서드와 함수 호출 p.136
func sendFile() -> String {
	do {
		try fileTransfer()
	} catch FileTransferError.noConnection {
		return "noConnection"
	} catch FileTransferError.lowBandWidth {
		return "lowBandWidth"
	} catch FileTransferError.fileNotFound {
		return "fileNotFound"
	} catch {
		return "unknown error"
	} catch let error {
		return error.localizedDescription
	}
	return "Successful transfer"
}

print(sendFile())

// 에러 캐칭 비활성화 p.137
let x = try? fileTransfer()

// 이 두 구문을 동일
let y: Int?
do {
	y = try fileTransfer()
} catch {
	y = nil
}

// try 뒤에 !로 강제로 실행한다면
// 에러가 절대 나지않을 것이라고 확신이 있는 경우에만 사용해야한다
// let z = try! fileTransfer()

func transfer() -> Int? {
	if let data = try? fileTransfer() { return data }
	return nil
}

// 에러 핸들링 예제 01
/*
 온도 변환 함수
 섭씨 온도를 화씨 온도로 변환하는 함수를 작성하세요.
 단, 섭씨 온도가 -273.15도보다 낮으면 InvalidTemperature 에러를 발생시키세요.
 (화씨온도 - 32) ÷ 1.8 = 섭씨온도 C
 (섭씨온도 × 1.8) + 32 = 화씨온도 F
 */
enum TemperatureError: Error {
	case invalidTemperature
}

func celsiusToFahrenheit(_ celsius: Double) throws -> Double {
	guard celsius >= -273.15 else { throw TemperatureError.invalidTemperature }
	return (celsius * 1.8) + 32
}

do {
	let fahrenheit = try celsiusToFahrenheit(-300)
	print(fahrenheit)
} catch TemperatureError.invalidTemperature {
	print("Invalid temperature")
}
// Invalid temperature

// 에러 핸들링 예제 02
/*
 비밀번호 검증 함수

 사용자가 입력한 비밀번호가 다음 조건을 만족하는지 검증하는 함수를 작성하세요.

 최소 8자 이상
 최소 하나의 대문자, 소문자, 숫자, 특수문자 포함
 
 조건을 만족하지 않으면 PasswordError 에러를 발생시키세요.
 */
enum PasswordError: Error {
	case tooShort, missingUppercase, missingLowercase, missingNumber, missingSymbol
}

func validatePassword(_ pwd: String) throws {
	guard pwd.count >= 8 else {
		throw PasswordError.tooShort
	}
	guard pwd.contains(where: { $0.isLowercase }) else {
		throw PasswordError.missingLowercase
	}
	guard pwd.contains(where: { $0.isUppercase }) else {
		throw PasswordError.missingUppercase
	}
	guard pwd.contains(where: { $0.isNumber }) else {
		throw PasswordError.missingNumber
	}
	guard pwd.contains(where: { "!@#$%^&*()_+-=[]{}|;:,./<>?".contains($0) }) else {
		throw PasswordError.missingSymbol
	}
}

do {
//	try validatePassword("abc123")
//	try validatePassword("abc123sdff")
	try validatePassword("abc123sdffE")
} catch let error as PasswordError {
	switch error {
	case .tooShort:
		print("Password is too short")
	case .missingUppercase:
		print("Password is missing an uppercase letter")
	case .missingLowercase:
		print("Password is missing a lowercase letter")
	case .missingNumber:
		print("Password is missing a number")
	case .missingSymbol:
		print("Password is missing a symbol")
	}
}
// Password is too short
// Password is missing an uppercase letter
// Password is missing a symbol

// 에러 핸들링 예제 03
/*
 ATM 기계 클래스
 ATM 기계를 나타내는 클래스를 작성하세요.
 다음 속성과 메서드를 구현하세요.

	- balance: 잔액을 나타내는 Double 타입의 속성. 초기값은 0이다.
 
	- deposit(amount: Double): 입금하는 메서드.
		 - amount가 0보다 크면 잔액에 더하고 true를 반환한다.
		 - 그렇지 않으면 false를 반환한다.
 
	- withdraw(amount: Double) throws -> Double: 출금하는 메서드.
		 - amount가 0보다 크고 잔액보다 작거나 같으면 잔액에서 빼고 amount를 반환한다.
		 - amount가 0보다 작으면 NegativeAmount 에러를 발생시킨다.
		 - amount가 잔액보다 크면 InsufficientBalance 에러를 발생시킨다.
 */
enum ATMError: Error {
	case negativeAmount, insufficientBalance
}

class ATM {
	var balance: Double = 0
	
	func deposit(amount: Double) -> Bool {
		if amount > 0 {
			self.balance += amount
			return true
		} else { return false }
	}
	
	func withdraw(amount: Double) throws -> Double {
		guard amount >= 0 else { throw ATMError.negativeAmount }
		guard amount <= self.balance else { throw ATMError.insufficientBalance }
		self.balance -= amount
		return balance
	}
}

let atm = ATM()
atm.deposit(amount: 1000)
print(atm.balance)              // 1000.0

do {
	let cash = try atm.withdraw(amount: 500)
	print(cash)                 // 500.0
} catch let error as ATMError {
	switch error {
	case .negativeAmount:
		print("Cannot withdraw a negative amount")
	case .insufficientBalance:
		print("Cannot withdraw more than balance")
	}
}

print(atm.balance)              // 500.0

// 에러 핸들링 예제 04
/*
 계산기 구조체
 사칙연산을 수행하는 계산기를 나타내는 구조체를 작성하세요.
 다음 속성과 메서드를 구현하세요.
	 - result: 계산 결과를 나타내는 Double 타입의 속성. 초기값은 0이다.
	 - add(_ number: Double): result에 number를 더하는 메서드.
	 - subtract(_ number: Double): result에 number를 빼는 메서드.
	 - multiply(_ number: Double): result에 number를 곱하는 메서드.
	 - divide(_ number: Double) throws: result에 number를 나누는 메서드.
			- 단, number가 0이면 DivisionByZero 에러를 발생시킨다.
 */
enum CalculatorError: Error {
	case divisionByZero
}

struct Calculator {
	var result: Double = 0
	
	mutating func add(_ number: Double) {
		result += number
	}
	
	mutating func subtract(_ number: Double) {
		result -= number
	}
	
	mutating func multiply(_ number: Double) {
		result *= number
	}
	
	mutating func divide(_ number: Double) throws {
		guard number != 0 else { throw CalculatorError.divisionByZero }
		result /= number
	}
}

var calculator = Calculator()
calculator.add(10)
print(calculator.result)        // 10.0

calculator.subtract(3)
print(calculator.result)        // 7.0

calculator.multiply(2)
print(calculator.result)        // 14.0

do {
		try calculator.divide(7)
		print(calculator.result)    // 2.0
} catch CalculatorError.divisionByZero {
		print("Cannot divide by zero")
}

// 에러 핸들링 예제 05
/*
 도서관 클래스
 도서관을 나타내는 클래스를 작성하세요.
 다음 속성과 메서드를 구현하세요.
	 - books: 책들을 나타내는 [String] 타입의 속성. 초기값은 빈 배열이다.
	 - limit: 대출 가능한 책의 수를 나타내는 Int 타입의 속성. 초기값은 3이다.
	 - borrow(book: String) throws -> String: 책을 대출하는 메서드.
		 - book이 books에 있고 limit보다 적게 대출했다면 book을 books에서 제거하고 "(book)을 대출했습니다."라는 문자열을 반환한다.
		 - book이 books에 없다면 BookNotFound 에러를 발생시키고, limit 이상으로 대출했다면 LimitExceeded 에러를 발생시킨다.
 */
enum LibraryError: Error {
	case bookNotFound, limitExceeded
}

class Library {
	private var books: [String] = []
	private var limit: Int = 3
	init(books: [String], limit: Int) {
		self.books = books
		self.limit = limit
	}
	
	func borrow(books: [String]) throws -> String {
		guard books.count <= limit else { throw LibraryError.limitExceeded }
		guard self.books.contains(books) else { throw LibraryError.bookNotFound }
		books.forEach { self.books.remove(at: self.books.firstIndex(of: $0)!) }
		return books.joined(separator: ",") + "을 대출했습니다."
	}
}

let library = Library(books: ["Harry Potter", "The Little Prince", "The Hobbit"], limit: 3)
do {
		let result = try library.borrow(books: ["Harry Potter", "The Little Prince"])
		print(result)
} catch LibraryError.bookNotFound {
		print("책을 찾을 수 없습니다.")
} catch LibraryError.limitExceeded {
		print("대출 한도를 초과했습니다.")
}
// limit: 1 일 경우 대출 한도를 초과했습니다.
// limit: 2 일 경우 The Harry Potter, Little Prince을 대출했습니다.

// 에러 핸들링 예제 06
/*
 JSON 파싱 함수
 JSON 형식의 문자열을 파싱하여 딕셔너리로 반환하는 함수를 작성하세요.
 단, JSON 형식이 올바르지 않으면 ParsingError 에러를 발생시키세요.
 */
enum ParsingError: Error {
	case invalidJSON
}

struct JsonData: Decodable {
	let name: String
	let age: Int
	let hobbies: [String]
}

let jsonString = """
{
		"name": "John",
		"age": 25,
		"hobbies": ["reading", "coding", "gaming"]
}
"""

//func parseJSON(_ json: String) throws -> [String: Any] {
//	guard let data = json.data(using: .utf8),
//				let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
//		throw ParsingError.invalidJSON
//	}
//	return dictionary
//}

func parseJSON(_ jsonString: String) throws -> [String : Any] {
	do {
		guard let data = jsonString.data(using: .utf8) else { throw ParsingError.invalidJSON }
		var dictionary: [String : Any] = [:]
		let json: JsonData = try JSONDecoder().decode(JsonData.self, from: data)
		dictionary["name"] = json.name
		dictionary["age"] = json.age
		dictionary["hobbies"] = json.hobbies
		return dictionary
	} catch {
		throw ParsingError.invalidJSON
	}
}

do {
	let dictionary = try parseJSON(jsonString)
	print(dictionary)
} catch ParsingError.invalidJSON {
	print("Invalid JSON format")
}
// ["name": "John", "age": 25, "hobbies": ["reading", "coding", "gaming"]]

