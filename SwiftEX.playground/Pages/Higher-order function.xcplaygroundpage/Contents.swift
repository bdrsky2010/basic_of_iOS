import Foundation

/*
 클로저 예제 01
 다음 코드에서 클로저의 반환 타입과 매개변수 타입을 추론하여 적어보세요.
 
 <정답>
 매개변수 타입: Int, Int
 클로저 반환타입: Int
 */
let add: (Int, Int) -> Int = { $0 + $1 }

/*
 클로저 예제 02
 다음 코드에서 클로저를 사용하여 배열의 모든 요소에 10을 곱한 새로운 배열을 만들어보세요.
 */
let numbers = [1, 2, 3, 4, 5]
let mulTenNumbers: [Int] = numbers.map { $0 * 10 }
print(mulTenNumbers)

/*
 클로저 예제 03
 다음 코드에서 클로저를 사용하여 배열의 홀수 요소만 필터링하여 새로운 배열을 만들어보세요.
 */
let oddNumbers: [Int] = numbers.filter { $0 % 2 == 1 }
print(oddNumbers)

/*
 클로저 예제 04
 다음 코드에서 클로저를 사용하여 배열의 요소들의 합을 구해보세요.
 */
let sumOfNumbers: Int = numbers.reduce(0, +)
print(sumOfNumbers)

/*
 클로저 예제 05
 다음 코드에서 클로저를 사용하여 배열의 요소들을 문자열로 변환하여 새로운 배열을 만들어보세요.
 */
let mappingOfNumber: [String] = numbers.map { String($0) }
print(mappingOfNumber)

/*
 맵, 필터, 리듀스 예제 01
 주어진 배열에서 홀수만 골라내서 제곱한 후 모두 더하는 함수를 작성하세요.
 */
let isOdd: (Int) -> Bool = { $0 % 2 == 1 }
let square: (Int) -> Int = { $0 * $0 }

func sumOfSquaresOfOdds(array: [Int]) -> Int {
	return array.filter(isOdd)
		.map(square)
		.reduce(0, +)
}

let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print(sumOfSquaresOfOdds(array: array))

/*
 맵, 필터, 리듀스 예제 02
 주어진 문자열에서 모음을 제거하고 대문자로 바꾼 후 역순으로 출력하는 함수를 작성하세요.
 */
let intToStr: (Character) -> String = { String($0) }

func reverseWithoutVowels(string: String) -> String {
	return String(string.filter { !"AaEeIiOoUu".contains($0) }
		.uppercased()
		.reversed())
}

let string = "Hello World"
print(reverseWithoutVowels(string: string))

/*
 맵, 필터, 리듀스 예제 03
 주어진 딕셔너리에서 값이 짝수인 값들의 합을 구하는 함수를 작성하세요.

 (보너스: 가능하신 분은 짝수인 값들의 키의 문자열 코드를 합하는 것을 시도해 보세요.)
 */
func sumOfKeysWithEvenValues(dictionary: [String: Int]) -> (valueTotal: Int, asciiTotal: Int) {
	return dictionary
		.filter { (key, value) in value % 2 == 0 }
		.reduce(into: (0, 0)) {
			$0.0 += $1.value
			$0.1 += Int(Character($1.key).asciiValue ?? 0)
		}
}

let dictionary = ["a": 1, "b": 2, "c": 3, "d": 4, "e": 5]
print(sumOfKeysWithEvenValues(dictionary: dictionary))

/*
 맵, 필터, 리듀스 예제 04
 주어진 배열에서 가장 큰 수와 가장 작은 수의 차이를 구하는 함수를 작성하세요.
 */
func differenceBetweenMaxAndMin(array: [Int]) -> Int {
//	return array.reduce(Int.min) { max($0, $1) } - array.reduce(Int.max) { min($0, $1) }
	return array.reduce(Int.min, max) - array.reduce(Int.max, min)
}

let array2 = [10, 20, 30, 40, 50]
print(differenceBetweenMaxAndMin(array: array2))

/*
 맵, 필터, 리듀스 예제 05
 주어진 배열에서 각 요소의 개수를 세어서 딕셔너리로 반환하는 함수를 작성하세요.
 */
func countElements(array: [String]) -> [String: Int] {
// 	var dict: [String: Int] = [:]
//	Set(array).forEach { alpha in
//		dict[alpha] = (dict[alpha] ?? 0) + array.reduce(0) { $0 + ($1 == alpha ? 1 : 0) }
//	}
//	return dict
	return array.reduce(into: [:]) { $0[$1] = ($0[$1] ?? 0) + 1}
}
let array3 = ["a", "b", "a", "c", "b", "d"]
print(countElements(array: array3))

/*
 맵, 필터, 리듀스 예제 06
 주어진 배열에서 가장 많이 등장하는 요소를 반환하는 함수를 작성하세요.

 만약 동률이 있다면 무작위로 하나를 반환.
 */
func mostFrequentElement(array: [String]) -> String {
//	var dict: [String: Int] = [:]
//	Set(array).forEach { alpha in
//		dict[alpha] = (dict[alpha] ?? 0) + array.reduce(0) { $0 + ($1 == alpha ? 1 : 0) }
//	}
//	return dict.max { $0.value < $1.value } == nil ? "" : dict.max { $0.value < $1.value }!.key
	return array.reduce(into: [:]) { $0[$1] = ($0[$1] ?? 0) + 1}.max(by: { $0.value < $1.value })!.key
}
let array4 = ["a", "b", "a", "c", "b", "d"]
print(mostFrequentElement(array: array4))

/*
 맵, 필터, 리듀스 예제 07
 주어진 배열에서 각 요소의 앞뒤로 "*"을 붙여서 새로운 배열을 반환하는 함수를 작성하세요.
 */
let plusStar: (String) -> String = { "*" + $0 + "*" }

func addStars(array: [String]) -> [String] {
	return array.map(plusStar)
}
let array5 = ["a", "b", "c"]
print(addStars(array: array5))

/*
 맵, 필터, 리듀스 예제 08
 주어진 배열에서 3의 배수만 골라내서 그 합을 구하는 함수를 작성하세요.
 */
func sumOfMultiplesOfThree(array: [Int]) -> Int {
	return array.reduce(0) { $0 + ($1 % 3 == 0 ? $1 : 0) }
}
let array6 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print(sumOfMultiplesOfThree(array: array6))

/*
 맵, 필터, 리듀스 예제 09
 주어진 배열에서 각 요소를 두 번 반복해서 새로운 배열을 반환하는 함수를 작성하세요.
 */
let oneMore: (String) -> String = { $0 + $0 }

func repeatTwice(array: [String]) -> [String] {
// return (array + array).sorted()
//	return array.reduce(into: [String]()) { $0.append($1); $0.append($1) }
//	return array.map { $0 + $0 }.joined().split(separator: "").map { String($0) }
//	return array.map(oneMore).joined().split(separator: "").map { String($0) }
	return array.map { [$0, $0] }.flatMap { $0 }
}
let array7 = ["a", "b", "c"]
print(repeatTwice(array: array7))

/*
 맵, 필터, 리듀스 예제 10
 주어진 배열에서 각 요소의 길이를 새로운 배열로 반환하는 함수를 작성하세요.
 */
let strSize: (String) -> Int = { $0.count }

func lengthsOfElements(array: [String]) -> [Int] {
	return array.map(strSize)
}

let array8 = ["apple", "banana", "cherry"]
print(lengthsOfElements(array: array8))

/*
 맵, 필터, 리듀스 예제 11
 주어진 문자열에서 모음(a, e, i, o, u)의 개수를 세는 함수를 작성하세요.
 */
func countVowels(_ word: String) -> Int {
	word.reduce(0) { $0 + ("aeiou".contains($1.lowercased()) ? 1 : 0) }
}

let word = "swift"
let vowelCount = countVowels(word)
print(vowelCount) // 1

/*
 맵, 필터, 리듀스 예제 12
 주어진 문자열에서 각 알파벳이 몇 번 나오는지 세는 함수를 작성하세요.
 */
func countAlphabets(_ word: String) -> [Character: Int] {
	word.reduce(into: [Character: Int]()) {
		$0[$1] = $1.isLetter ? ($0[$1] ?? 0) + 1 : nil
	}
}

let word2 = "Hello2World!!"
let alphabetCount = countAlphabets(word2)
print(alphabetCount)  // ["e": 1, "o": 2, "r": 1, "H": 1, "W": 1, "d": 1, "l": 3]

/*
 맵, 필터, 리듀스 예제 13
 주어진 문자열에서 각 단어의 첫 글자를 대문자로 바꾸는 함수를 작성하세요.
 */
func capitalize(_ sentence: String) -> String {
//	sentence.capitalized(with: .current)
	sentence
		.components(separatedBy: " ")
		.reduce(into: [String]()) { $0.append($1.prefix(1).uppercased() + $1.suffix($1.count - 1)) }
		.joined(separator: " ")
}
let sentence = "this is a test"
let capitalizedSentence = capitalize(sentence)
print(capitalizedSentence)      // "This Is A Test"

/*
 맵, 필터, 리듀스 예제 14
 주어진 배열에서 각 요소를 역순으로 정렬하는 함수를 작성하세요.

 (컬렉션에서 제공하는 역순함수를 사용하지 않고 구현해 보세요.)
 */

func reverse(_ numbers: [Int]) -> [Int] {
	numbers
		.indices
		.reduce(into: numbers) { (result, i) in
			(0..<result.count - 1 - i ).forEach { j in
				if result[j] < result[j + 1] { result.swapAt(j, j + 1) }
			}
		}
}

let numbers2 = [1, 3, 4, 2, 5]
let reversedNumbers = reverse(numbers)
print(reversedNumbers)      // [5, 2, 4, 3, 1]

/*
 맵, 필터, 리듀스 예제 15
 주어진 문자열에서 모든 소문자를 대문자로 바꾸는 함수를 작성하세요.

 (보너스: 대문자는 소문자로 소문자는 대문자로 시도해 보세요.)
 */
func uppercase(_ word: String) -> String {
	word.reduce(into: "") { $0 += ($1.isUppercase ? $1.lowercased() : $1.uppercased()) }
}

let word3 = "swift"
let uppercasedWord = uppercase(word3)
print(uppercasedWord)       // "SWIFT"

/*
 맵, 필터, 리듀스 예제 16
 주어진 문자열에서 모든 공백을 제거하는 함수를 작성하세요.
 */
func removeSpaces(_ sentence: String) -> String {
	sentence.filter { !$0.isWhitespace }
}

let sentence2 = "This is a test"
let noSpaceSentence = removeSpaces(sentence2)
print(noSpaceSentence)      // "Thisisatest"
