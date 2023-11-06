import Foundation
/*
 프로토콜지향 프로그래밍 (Protocol Oriented Programming, POP)
 스위프트 표준 라이브러리를 보면 타입과 관련된 코드들이 대부분 구조체 형태로 되어 있음(클래스가 아닌)
 
 구조체 형태면 상속이 안됨, 그러면 기능 확장은?
 프로토콜 + 익스텐션 .....> 제너릭
 프로토콜과 익스텐션의 결합
 */
/*:
 ## 프로토콜(protocol) 소개 p.96
 
 타입이 구현해야 하는 요구사항을 정의하는 규칙들의 집합
 
 구조체, 클래스, 열거형이 반드시 포함해야 하는 메서드와 프로퍼티를 정의
 */
protocol MessageBuilder {
	var name: String { get }
	func buildMessage() -> String
}

class MyClass: MessageBuilder {
	var name: String
	
	init(name: String) {
		self.name = name
	}
	
	func buildMessage() -> String {
		return "Hello " + name
	}
	
	// 클래스에서 타입 메서드
	class func calcName(name: String, str: String) -> String {
		return name + " " + str
	}
}

MyClass.calcName(name: "park", str: "good")

/**
 ## 프로토콜 채택 예시
 protocol 프로토콜 이름 {
 // 프로토콜 정의
 }
 
 class MyClass: 프로토콜 이름 {
 // 클래스 정의
 }
 
 struct MyStruct: 프로토콜 이름 {
 // 구조체 정의
 }
 
 enum MyEnum: 프로토콜 이름 {
 // 열거형 정의
 }
 */


// 프로퍼티 요구사항
protocol MyProtocol {
	// var fullName: String { get set }
	var mustBeValue: Int { get set }
	var doesNotNeedToValue: Int { get }
}

protocol MyProtocolFullName {
	var fullName: String { get set }
}

struct MyStruct: MyProtocol {
	
	var mustBeValue: Int {
		get { return 0}
		set { }
	}
	
	var doesNotNeedToValue: Int {
		get { return 0}
	}
	
}
//let my = MyStruct()
//my.mustBeValue


// 메서드 요구사항
protocol MyProtocolMethod {
	func random() -> Double
}

// 타입 메서드 요구사항...
protocol MyProtocolMethod2 {
	static func randomG() -> Double
}

struct MyMethod: MyProtocolMethod, MyProtocolMethod2 {
	func random() -> Double {
		return 0.0
	}
	
	// 타입 메서드를 구조체에서 구현하기 위해서는 static func 로 시작
	static func goodMethod() -> String {
		return "good"
	}
	
	static func randomG() -> Double {
		return 1.1
	}
}


// 타입 메서드
MyMethod.goodMethod()

// 인스턴스 메서드
let myMethod = MyMethod()
myMethod.random()


// 열거형

print("end")

/*
 프로토콜 예제 01
 다음 프로토콜을 채택하는 Person 구조체를 정의하고, 프로토콜의 메서드를 구현하세요.
 */
protocol Greeting {
	var name: String { get }
	func sayHello()
}

struct Person: Greeting {
	var name: String
	
	func sayHello() {
		print("Hello, \(name)")
	}
}

let person = Person(name: "park")
person.sayHello()     // Hello, park!

/*
 프로토콜 예제 02
 다음 프로토콜을 채택하는 Circle 클래스를 정의하고, 프로토콜의 연산 프로퍼티를 구현하세요.
 */
protocol Shape {
	var area: Double { get }
}

class Circle: Shape {
	var radius: Double
	var area: Double {
		get { radius * radius * .pi }
	}
	init(radius: Double) {
		self.radius = radius
	}
}

let circle: Circle = Circle(radius: 6)
print(circle.area)

/*
 프로토콜 예제 03
 다음 프로토콜을 채택하는 Car 구조체를 정의하고, 프로토콜의 타입 메서드를 구현하세요.
 */
protocol Vehicle {
	static func makeNoise()
}

struct Car: Vehicle {
	static func makeNoise() {
		print("부릉부릉")
	}
}
Car.makeNoise()

/*
 프로토콜 예제 04
 다음 프로토콜을 채택하는 Counter 클래스를 정의하고, 프로토콜의 타입 연산 프로퍼티를 구현하세요.
 */
protocol Countable {
	static var count: Int { get set }
}

class Counter: Countable {
	static var count: Int = 2
}
print(Counter.count)

/*
 프로토콜 예제 05
 Equatable 프로토콜을 채택한 Student 구조체를 정의하고, 두 Student 인스턴스가 같은지 비교하는 == 연산자를 구현해보세요.
 */

struct Student: Equatable {
	var name: String
	var age: Int
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.age == rhs.age
	}
}
let alice = Student(name: "Alice", age: 20)
let bob = Student(name: "Bob", age: 21)

print(alice == bob) // false

/*
 프로토콜 예제 06
 다음 코드에서 Person 클래스를 프로토콜로 변환하고, Student 클래스가 이 프로토콜을 준수하도록 수정해보세요.
 */
//class Person {
//	var name: String
//	var age: Int
//
//	init(name: String, age: Int) {
//		self.name = name
//		self.age = age
//	}
//
//	func introduce() {
//		print("My name is \(name) and I'm \(age) years old.")
//	}
//}

protocol Person2 {
	var name: String { get set }
	var age: Int { get set }
	
	init(name: String, age: Int)
	
	func introduce()
}

class Student2: Person2 {
	var name: String
	var age: Int
	var school: String {
		if age <= 13 { return "elementry school" }
		else if age <= 16 { return "middle school" }
		else if age <= 19 { return "high school" }
		return "university"
	}
	
	required init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
	
	func introduce() {
		print("My name is \(name) and I'm \(age) years old.I go to \(school).")
	}
}

let student2: Student2 = Student2(name: "범인", age: 17)
student2.introduce()

/*
 프로토콜 예제 07
 프로토콜을 채택하고 준수하는 클래스를 정의하고, 해당 클래스의 인스턴스를 생성하고 프로토콜의 메서드를 호출하는 코드를 작성해보세요.
 
 프로토콜의 이름은 Speaker이고, 인사말을 출력하는 메서드 speak(message: String)을 가지고 있습니다.
 */

protocol Speaker {
	func speak(message: String)
}

class Person3: Speaker {
	func speak(message: String) {
		print(message)
	}
}

let person3 = Person3()
person3.speak(message: "안녕 내이름은 안알려줄거임 ㅅㄱ")

/*
 프로토콜 예제 08
 프로토콜을 상속받는 서브 프로토콜을 정의하고, 해당 프로토콜을 채택하고 준수하는 구조체를 정의하세요.
 */
//protocol Animal {
//		var name: String { get }
//		func makeSound()
//}
//
//protocol Pet: Animal {
//		var owner: String { get }
//}
//
//struct Dog: Pet {
//		var name: String
//		var owner: String
//
//		func makeSound() {
//				print("Woof!")
//		}
//
//}
//
//let bob = Dog(name: "Bob", owner: "Charlie")
//bob.makeSound()     // Woof!

/*
 프로토콜 예제 09
 프로토콜에 연산 프로퍼티와 타입 메서드를 선언하고, 해당 프로토콜을 채택하고 준수하는 클래스를 정의하세요.
 */
protocol Calculable {
	var value: Int { get set }
	static func calc(_ a: Int, _ b: Int, _ operation: (Int, Int) -> Int) -> Int
}

class Calculator: Calculable {
	var value: Int = 0
	static func calc(_ a: Int, _ b: Int, _ operation: (Int, Int) -> Int) -> Int {
		return operation(a, b)
	}
}

let calculator: Calculator = Calculator()
calculator.value = Calculator.calc(100, 20) { ($0 - $1) * $1 }
print(calculator.value)

/*
 프로토콜 예제 10
 프로토콜을 확장하여 기본 구현을 제공하고, 해당 프로토콜을 채택하고 준수하는 열거형을 정의하세요.
 */
protocol Colorful {
	var color: String { get }
	func describe()
}

extension Colorful {
	func describe() {
		print("This is \(color).")
	}
}

enum Fruit: Colorful {
	case apple, banana, grape
	
	var color: String {
		switch self {
		case .apple:
			return "red"
		case .banana:
			return "yellow"
		case .grape:
			return "purple"
		}
	}
}
let fruit = Fruit.apple
fruit.describe()        // This is red.
Fruit.banana.describe() // This is yellow.

/*
 프로토콜 예제 11
 Protocol 을 채택한 클래스, 구조체, 열거형에 공통된 기능을 추가하고 싶을 때, 어떤 방법을 사용해야 할까요?

 다음 예시 코드 결과가 출력되도록 코드를 추가해 보세요.
 */

protocol Animal {
		var name: String { get }
		func makeSound()
}

class Dog: Animal {
		var name: String

		init(name: String) {
				self.name = name
		}

		func makeSound() {
				print("Woof!")
		}
}

struct Cat: Animal {
		var name: String

		func makeSound() {
				print("Meow!")
		}
}

enum Bird: Animal {
		case parrot(String)
		case sparrow(String)

		var name: String {
				switch self {
				case .parrot(let name):
						return name
				case .sparrow(let name):
						return name
				}
		}

		func makeSound() {
				switch self {
				case .parrot:
						print("Hello!")
				case .sparrow:
						print("Chirp!")
				}
		}
}

// 추가 코드
//...
extension Animal {
	func introduce() {
		print("My name is \(name)")
	}
}

let dog = Dog(name: "Max")
let cat = Cat(name: "Lily")
let bird = Bird.parrot("Jack")

dog.introduce()     // My name is Max.
cat.introduce()     // My name is Lily.
bird.introduce()    // My name is Jack.

/*
 로토콜 예제 12
 다음 프로토콜을 채택하는 구조체를 정의하고, 프로토콜의 익스텐션으로 메서드를 추가하세요.
 */

protocol Flyable {
	var speed: Double { get set }
}

struct Bird2: Flyable {
	var speed: Double
}

extension Flyable {
	func fly() {
		print("flying speed: \(speed)")
	}
}

let bird2 = Bird2(speed: 30)
bird2.fly()

/*
 프로토콜 예제 13
 다음 프로토콜을 채택하는 구조체를 정의하고, 프로토콜의 익스텐션으로 연산 프로퍼티를 추가하세요.
 */

protocol Colorful2 {
	var color: String { get set }
}
struct Flower: Colorful2 {
	var color: String
}

extension Colorful2 {
	var description: String {
		return "A \(color) thing"
	}
}

//...
let flower = Flower(color: "Yellow")
print( flower.description )     // A Yellow thing
