import Foundation

// Optionals(옵셔널)

// 옵셔널의 정식 표기법
let num1: Optional<Int>

// 옵셔널의 간단 표기법
let num2: Int?

// 옵셔널 타입끼리 연산은 불가능
let numA: Int? = 20
let numB: Int? = 25
// error: binary operator '+' cannot be applied to two 'Int?' operands
//let numC: Int? = numA + numB

// 옵셔널열거형의 switch-case 활용

enum SomeEnum {
	case left, right
}
let x: SomeEnum? = .left

// 원칙
switch x {
case .some(let value):
	switch value {
	case .left:
		print("왼쪽으로")
	case .right:
		print("오른쪽으로")
	}
case .none:
	print("계속 전진")
}

// 편의적 기능 제공
switch x {
case .some(.left):
	print("왼쪽으로")
case .some(.right):
	print("오른쪽으로")
case .none:
	print("계속 전진")
}

// swift문에서 옵셔널 열거형 타입을 사용할 때, 언래핑 하지않아도 내부값에 접근이 가능
switch x {
case .left:
	print("왼쪽으로")
case .right:
	print("오른쪽으로")
case .none:
	print("계속 전진")
}

// 열거형 케이스 패턴(forans) - 옵셔널타입 요소 배열
let arr: [Int?] = [nil, 1, 2, 3, nil]

for case let .some(number) in arr {
	print("Fount a \(number)")
}

// 옵셔널 패턴
switch x {
case let z?: // .some을 조금 더 간소화하는 문법
	print(z)
case nil: // .none 혹은 nil 쓰면됨
	print("nil")
}
