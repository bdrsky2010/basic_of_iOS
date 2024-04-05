import Foundation

/**
 # @unknown 키워드
 - 만약 전에 선언해놓은 enum의 case가 늘어난다면 (Non-frozen 열거형)
 - 실제 프로젝트에서는 늘어날 수 있는 경우가 많음
 */

enum LoginProvider {
	case email
	case facebook
	case google
	
	case kakaotalk
}

/**
 - @unknown 키워드를 default블럭에 추가
 
 - switch문에서 열거형의 모든 케이스를 다루지 않는 경우,
	스위치문에서 모든 열거형의 케이스를 다루지 않았다고
	경고를 통해 알려줌 ===> 개발자의 실수 가능성을 컴파일 시점에 알려줌
 */
let userLogin = LoginProvider.google
switch userLogin {
case .email:
	print("이메일 로그인")
case .facebook:
	print("페이스북 로그인")
case .google:
	print("구글 로그인")
@unknown default:
	print("그 외의 모든 경우")
}

// 열거형 예제 01
enum Suit {
	case spade, heart, diamon, club
}

enum Rank {
	case ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

struct Card {
	var suit: Suit
	var rank: Rank
}

func compareCards(card1: Card, card2: Card) {
	switch (card1.suit == card2.suit, card1.rank == card2.rank) {
	case (true, true):
		print("두 카드는 모두 같습니다.")
		break
	case (true, false):
		print("두 카드는 같은 무늬입니다")
		break
	case (false, true):
		print("두 카드는 같은 숫자입니다")
		break
	default:
		print("두 카드는 모두 다릅니다")
		break
	}
}

let card1: Card = Card(suit: .spade, rank: .ace)
let card2: Card = Card(suit: .spade, rank: .eight)
compareCards(card1: card1, card2: card2)


// 열거형 예제 02
enum Animal {
	case dog(name: String)
	case cat(name: String)
	case bird(name: String)
}

func checkAnimal(animals: [Animal]) {
	animals.forEach {
		switch $0 {
		case .dog(let name):
			print("이 동물은 개이고 이름은 \(name)입니디.")
		case .cat(let name):
			print("이 동물은 고양이이고 이름은 \(name)입니디.")
		case .bird(let name):
			print("이 동물은 새이고 이름은 \(name)입니디.")
		}
	}
}

let animals = [Animal.dog(name: "바둑이"), Animal.cat(name: "나비"), Animal.bird(name: "짹짹이")]
checkAnimal(animals: animals)

// 열거형 예제 03
enum Season: String {
	case Spring = "spring"
	case Summer = "summer"
	case Autumn = "autumn"
	case Winter = "winter"
}

enum SeasonError: Error {
	case monthError
	case dayError
}

func getSeason(date: (Int, Int)) throws -> String {
	let month: Int = date.0
	let day: Int = date.1
	do {
		guard 0 < day && day < 32 else { throw SeasonError.dayError }
		
		switch month {
		case 3...5:
			return Season.Spring.rawValue
		case 6...8:
			return Season.Summer.rawValue
		case 9...11:
			return Season.Autumn.rawValue
		case 12,1,2:
			return Season.Winter.rawValue
		default:
			throw SeasonError.monthError
		}
	} catch SeasonError.monthError {
		print("Error :: month input 0 < month < 13")
	} catch SeasonError.dayError {
		print("Error :: day input 0 < day < 32")
	}
	return ""
}

let today = (month: 10, day: 17)
let season = try getSeason(date: today)

print("오늘은 \(season)입니다.")  // 오늘은 autumn입니다.
print("오늘은 \( try getSeason(date: (month: 13, day: 17)) )입니다.")      // 오늘은 summer입니다.
print("오늘은 \( try getSeason(date: (month: 12, day: 15)) )입니다.")     // 오늘은 winter입니다.
print("오늘은 \( try getSeason(date: (month: 3, day: 1)) )입니다.")       // 오늘은 spring입니다.

//func getSeason(date: (Int, Int)) -> String {
//	switch date {
//	case (let month, let day) where (3 <= month && month <= 5) || (month == 3 && day >= 14) || (month == 5 && day <= 30):
//		return Season.Spring.rawValue
//	case (let month, let day) where (5 <= month && month <= 9) || (month == 5 && day >= 31) || (month == 9 && day <= 21):
//		return Season.Summer.rawValue
//	case (let month, let day) where (9 <= month && month <= 11) || (month == 9 && day >= 22) || (month == 11 && day <= 27):
//		return Season.Autumn.rawValue
//	case (let month, let day) where (11 <= month || month <= 3) || (month == 11 && day >= 28) || (month == 3 && day <= 13):
//		return Season.Winter.rawValue
//	default:
//		return ""
//	}
//}

// 열거형 예제 04
enum Operator {
	case add, subtract, multiply, divide
}

func calculate(num1: Int, num2: Int, op: Operator) -> String {
	switch op {
	case.add:
		return String(num1 + num2)
	case .subtract:
		return String(num1 - num2)
	case .multiply:
		return String(num1 * num2)
	case .divide:
		return String(Double(num1) / Double(num2))
	}
}

let result = calculate(num1: 10, num2: 5, op: .divide)

print("결과는 \(result)입니다.")      //결과는 2입니다.
print("결과는 \( calculate(num1: 10, num2: 5, op: .add) )입니다.")        //결과는 15입니다.
print("결과는 \( calculate(num1: 10, num2: 5, op: .subtract) )입니다.")   //결과는 5입니다.
print("결과는 \( calculate(num1: 10, num2: 5, op: .multiply) )입니다.")   //결과는 50입니다.

// 열거형 예제 05
enum Beverage {
	case coffee(price: Int)
	case tea(price: Int)
	case juice(price: Int)
}

func printTypeAndPrice(beverages: [Beverage]) {
	beverages.forEach {
		switch $0 {
		case .coffee(let price):
			print("이 음료는 커피이고 가격은 \(price)원입니다.")
		case .tea(let price):
			print("이 음료는 차이고 가격은 \(price)원입니다.")
		case .juice(let price):
			print("이 음료는 주스이고 가격은 \(price)원입니다.")
		}
	}
}
let beverages = [Beverage.coffee(price: 3000), Beverage.tea(price: 2000), Beverage.juice(price: 2500)]
printTypeAndPrice(beverages: beverages)
/*
 출력결과
 이 음료는 커피이고 가격은 3000원입니다.
 이 음료는 차이고 가격은 2000원입니다.
 이 음료는 주스이고 가격은 2500원입니다.
*/

// 열거형 예제 06
enum Direction {
	case up, down, left, right
}

func move(position: (Int, Int), direction: Direction) -> (Int, Int) {
	let x: Int = position.0
	let y: Int = position.1
	switch direction {
	case.up:
		return (x, y + 1)
	case.down:
		return (x, y - 1)
	case.left:
		return (x - 1, y)
	case.right:
		return (x + 1, y)
	}
}

let currentPosition = (x: 0, y: 0)

var nextPosition: (x: Int, y: Int) = move(position: currentPosition, direction: .right)
print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")  // 다음 위치는 (1, 0)입니다.

nextPosition = move(position: currentPosition, direction: .left)
print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")  // 다음 위치는 (-1, 0)입니다.

nextPosition = move(position: currentPosition, direction: .up)
print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")  // 다음 위치는 (0, 1)입니다.

nextPosition = move(position: currentPosition, direction: .down)
print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")  // 다음 위치는 (0, -1)입니다.

// 열거형 예제 07
enum Dice: CaseIterable { // CaseIterable -> 열거형의 case 들을 배열로 만들 수 있다
	case one, two, three, four, five, six
}

print(Dice.allCases[2])

func rollDice() -> Dice {
	Dice.allCases.randomElement()!
}

(1...6).forEach { _ in
	print("주사위의 면은 \(rollDice())입니다.")   // 주사위의 면은 two입니다.
}

// 실행할 때마다 다음 6가지 경우중 랜덤하게 출력
// 주사위의 면은 one입니다.
// 주사위의 면은 three입니다.
// 주사위의 면은 four입니다.
// 주사위의 면은 five입니다.
// 주사위의 면은 six입니다.

//
// 열거형 예제 07
enum Color {
	case red(r: Int, g: Int, b: Int)
	case green(r: Int, g: Int, b: Int)
	case blue(r: Int, g: Int, b: Int)
}

func printColors(colors: [Color]) {
	colors.forEach {
		switch $0 {
		case.red(let r, let g, let b):
			print("이 색상은 빨강이고 RGB 값은 (\(r), \(g), \(b))입니다.")
		case.green(let r, let g, let b):
			print("이 색상은 초록이고 RGB 값은 (\(r), \(g), \(b))입니다.")
		case.blue(let r, let g, let b):
			print("이 색상은 파랑이고 RGB 값은 (\(r), \(g), \(b))입니다.")
		}
	}
}

let colors = [Color.red(r: 255, g: 0, b: 0), Color.green(r: 0, g: 255, b: 0), Color.blue(r: 0, g: 0, b: 255)]
printColors(colors: colors)
// 출력결과
/*
 이 색상은 빨강이고 RGB 값은 (255, 0, 0)입니다.
 이 색상은 초록이고 RGB 값은 (0, 255, 0)입니다.
 이 색상은 파랑이고 RGB 값은 (0, 0, 255)입니다.
*/

/* 구조체에도 구조체처럼 프로퍼티를 선언해줄 수 있음
 enum Color {
		 case red(r: Int, g: Int, b: Int)
		 case green(r: Int, g: Int, b: Int)
		 case blue(r: Int, g: Int, b: Int)
		 
		 var name: String {
				 switch self {
				 case .red:
						 return "빨강"
				 case .green:
						 return "초록"
				 case .blue:
						 return "파랑"
				 }
		 }
		 
		 var rgb: (Int, Int, Int) {
				 switch self {
				 case .red(let r, let g, let b),
							.green(let r, let g, let b),
							.blue(let r, let g, let b):
						 return (r, g, b)
				 }
		 }
 }

 func printColors(colors: [Color]) {
		 colors.forEach { color in
				 let (r, g, b) = color.rgb
				 print("이 색상은 \(color.name)이고 RGB 값은 (\(r), \(g), \(b))입니다.")
		 }
 }
 */
