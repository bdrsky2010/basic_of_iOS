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
