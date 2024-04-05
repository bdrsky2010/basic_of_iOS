import Foundation

/**
 # Optionals(옵셔널)
 
 # Optionals(옵셔널) 타입에 대한 이해
 ## Optional 이란 무엇인지 설명해보세요.
	- 메모리 공간에 임시적인 타입을 담아두어 값이 없어도 실제로 값이 없는 것이 아닌 값이 없음을 표한하는 값인 nil을 만나게되어
	해당 메모리 위치에 접근을 하여도 앱이 꺼지게되는 에러를 발생하지 못하도록 방지하기 위한 타입
	- 옵셔널 타입으로 변수를 선언하게되면 값을 초기화하지 않더라도 자동적으로 nil로 초기화가 된다
 
 ## 옵셔널타입을 왜 쓰는건가요? 일반타입도 있는데, 옵셔널 타입이 왜 필요한건가요?
	- 모든 프로그래밍 언어는 어떠한 타입의 변수를 선언하고 값을 저장해주지 않은 경우 해당 변수에 접근했을 때 에러가 발생한다.
	- 실제로는 앱이 크래시가 나버린다.
	- 이런 상황에서 앱이 꺼지지 않도록 하기 위해서 옵셔널이라는 개념을 도입
 
 ## Null은 왜 앱이 왜 꺼지는지? 그런데, Swift의 nil은 왜 앱이 안꺼지는지? (다른 언어는 그렇지 않기도 함)
	- Null의 경우  실제로 값이 없음을 의미하는 키워드로서 메모리에 값이 할당이 되지 않을 상태에서 접근을 하여 앱이 꺼지게되고
	- nil의 경우 메모리 공간에 임시 타입으로 포장지처럼 감싸놓는다. 그래서 사용을 하기 위해서는 해당 임시 타입을 벗겨서 사용을 해야하며 nil을 갖고있는 	메모리에 접근을 하여도 값이 없는 것이 아닌 값이 없음을 나타내는 값에 접근을 하기 때문에 앱이 꺼지지 않는다. 다만 ! 키워드를 사용한 강제 언래핑으로 nil 	을 갖고있는 변수의 포장지를 벗겨버리면 실제로 값이 없는 Null을 만나버리기 때문에 앱이 꺼질 수 있다.
 
 ## Null과 nil의 차이점이 뭔가요?
	- Null: Null은 실제로 값이 없음을 의미
	- nil: nil은 실제로 값이 없는 것이 아닌 값이 없을 표현하는 키워드
 
 ## 옵셔널에 대해서는 알고 있나요? 옵셔널 바인딩 처리는 어떻게 하나요?
	- 옵셔날 바인딩에는 2가지 방법이 있다
	- if let 바인딩 - 원래 if문에서는 if 키워드 다음에는 참과 거짓을 판별할 수 있는 조건문이 와야하는데 옵셔널인 변수에 값이 존재하여 새로운 상수에 해당 				값이 담긴다면 이라는 조건문인 셈이다.
	- guard let 바인딩 - guard let 바인딩의 경우 함수에서 많이 사용되는데 if let과 거의 흡사한 방식이지만 함수 실행 후 초반에 옵셔널 타입의 변수에 값이 				있으면 코드를 계속 실행하고, nil 이 있다면 함수를 return하는 방식으로 많이 사용한다.(에러를 throw하는 방식으로 많이 사용)
 
 ## 옵셔널에서 ! (느낌표)는 언제 써야할까요?
	- 강제로 래핑된 값을 추출(Forced Unwrapping)하는 키워드
	- 값이 있다는 것을 확인할 수 있는 경우에만 사용
 
 ## Optional Chaining(?)과 nil-coalescing operator(??)의 차이점과 사용 시 주의사항은 무엇인가요?
	- Optional Chaining(?): 옵셔널 타입으로 선언된 값에 접근하여 해당 타입의 속성, 메서드를 사용할 때 접근연산자(.)앞에 ?를 붙이는 방식으로 무분별하게 					체이닝을 사용하여 값에 접근하게되면 중간에 어떤 메서드나 속성에서 nil을 return한 지 알아보기가 어려워 상황을 보면서 사용을 					하는 것이 	좋아보인다.
		- 결과값을 항상 wrapping된 옵셔널타입의 형태로 return 받게된다.
		- 옵셔널 체이닝 과정에서 값 중 하나라도 nil을 return한다면, 이어지는 표현식은 확인하지않고 nil을 return한다.
	- nil-coalescing operator(??): 옵셔널 변수를 사용하는 코드에서 옵셔널 변수 뒤에 물음표 2개를 작성 후(??) 그 뒤에 default 값을 제시해주는 방식으로
							직접 unwrapping 하는 것이 아닌, 값이 없으면 default 값을, 값이 있다면 해당 값을 전달하여 옵셔널 변수에 접근했을 						때 nil인 경우의 가능성을 없애는 방식이다.
	- Optional Chaining과 nil-coalescing operator 둘 다 옵셔널 타입의 값에 접근하기 위한 것이지만, 체이닝의 경우 nil을 받을 수 있고, nil-coalescing의 		경우 nil 아니면 default로 제시한 값을 받을 수 있다. 즉, 둘을 함께 사용할 수도 있는 것이다.
 
 ## Optional을 Switch 문으로 돌릴 때, .none이 있는데 이 것과 nil의 차이점은?
	- .none의 경우 옵셔널 타입의 값이 nil 일 경우 .none으로 나타내게 되는데.
	- .none은 옵셔널 타입의 값이 nil인지 확인을 하는 것이다. 즉, .none과 nil은 동일하다 라고 보는 것이 맞다.
	- switch case문에서 Optional Binding이 가능
		- case .none이 아닌 case let .some(value) 로 받게되면 값이 있는 경우 unwrapping된 값을 받아서 사용할 수 있다.
 */

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
