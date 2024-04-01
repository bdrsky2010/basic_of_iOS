import Foundation

// 함수를 좀 더 deep하게 공부해보자

/**
 # 가변파라미터(Variadic Parameters)를 가진 함수
 - 하나의 매개변수로 여러개의 매개변수를 보낼 수 있다
 - 가변 파라미터로 전달 받은 데이터는 배열 형태로 전달
 - 가변 파라미터는 함수마다 1개씩만 보유 가능
 - 가변 파라미터는 기본값을 가질 수 없다
 */

func printNames(_ names: String...) -> [String] {
	return names
}

print(printNames("둘리", "고길동", "또치", "마이콜"))

struct Friend {
	let name: String
	let age: Int
	let hobby: [String]
}

// 가변 파리미터의 선언 순서는 상관이 없다
func introduce(name: String, age: Int, hobby: String...) -> Friend {
	return Friend(name: name,
				  age: age,
				  hobby: hobby)
}

print(introduce(name: "마이콜", age: 35, hobby: "기타", "라면먹기", "작사", "작곡"))

/**
 # 함수를 지칭할 때, 함수 표기법
 - 함수를 변수에 담는 경우
 */

func printSomething() {
	print("어쩌구저쩌구")
}

func printMyName(name: String) {
	print("제 이름은 \(name)입니다.")
}

func printFullName(lastName: String, firstName: String) {
	print("성은 \(lastName)이고 이름은 \(firstName)입니다.")
}

func calcSquareArea(_ width: Int, _ height: Int) -> Int {
	return width * height
}

// 1) 파라미터가 없는 경우 ()없이 표기
printSomething
var something = printSomething
something()

// 2) 파라미터가 있는 경우 아규먼트 레이블까지 표기
printMyName(name:)
var myName = printMyName(name:)
myName("민재")

// 3) 파라미터가 여러개인 경우, 콤마없이 (아규먼트 레이블:아규먼트 레이블) 처럼 표기
printFullName(lastName:firstName:)
var myFullName = printFullName(lastName:firstName:)
myFullName("김", "민재")

// 4) 아규먼트 레이블이 생략된 경우
calcSquareArea(_:_:)
var area = calcSquareArea(_:_:)
area(20, 30)


/**
 # 함수의 타입 표기 방법
 */
var function1: () -> Void = printSomething
var function2: (Int, Int) -> Int = calcSquareArea(_:_:)

/**
 # 함수의 오버로딩
 - 동일한 이름을 가진 함수에 매개변수를 다르게 선언하여, 동일한 이름의 함수에 여러개의 함수를 사용할 수 있게 하는 것
	- 함수 이름을 재사용하는 것
 */

func introduction(name: String) {
	print("안녕하세요 저의 이름은 \(name)입니다.")
}
func introduction(name: String, age: Int) {
	print("안녕하세요 저의 이름은 \(name)입니다.\n저의 나이는 \(age)살 이구요.")
}
func introduction(name: String, age: Int, hobby: String...) {
	print("안녕하세요 저의 이름은 \(name)입니다.\n저의 나이는 \(age)살 이구요.\n저의 취미는 \(hobby)입니다.")
}
