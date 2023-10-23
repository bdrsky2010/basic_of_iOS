import Foundation

/*
 딕셔너리 예제 01
 다음과 같은 딕셔너리가 주어졌을 때, 가장 많이 등장하는 값(value)을 출력하는 함수를 작성하세요.
 */
func mostFrequentValue(dict: [String: Int]) -> Int {
	var result: [Int:Int] = [:]
	dict.values.forEach {
		result[$0] = (result[$0] ?? 0) + 1
	}
	return result.max(by: { $0.value < $1.value })!.0
}
let dict1 = ["a": 1, "b": 2, "c": 3, "d": 2, "e": 2]
mostFrequentValue(dict: dict1)  // 2

/*
 딕셔너리 예제 02
 다음과 같은 딕셔너리가 주어졌을 때, 키(key)와 값(value)의 순서를 바꾼 새로운 딕셔너리를 반환하는 함수를 작성하세요.

 (단, 값(value)이 중복되는 경우는 고려하지 않는다.)
 */

func reverseKeyValue(dict: [String: String]) -> [String: String] {
	return Dictionary(uniqueKeysWithValues: zip(dict.values, dict.keys))
}

let dict2 = ["apple": "red", "banana": "yellow", "grape": "purple"]
let result1 = reverseKeyValue(dict: dict2)
print(result1)       // ["red": "apple", "yellow": "banana", "purple": "grape"]

/*
 딕셔너리 예제 03
 다음과 같은 딕셔너리가 주어졌을 때, 특정한 값(value)을 가진 모든 키(key)의 리스트(list)를 반환하는 함수를 작성하세요.
 */
func keysWithValue(dict: [String: Int], value: Int) -> [String] {
	return dict.filter { $0.value == value }.map { $0.0 }
}

let dict3 = ["a": 1, "b": 2, "c": 3, "d": 2, "e": 1]
let result2 = keysWithValue(dict: dict3, value: 2)
print(result2)       // ["d", "b"]

/*
 딕셔너리 예제 04
 다음과 같은 딕셔너리가 주어졌을 때, 모든 키(key)와 값(value)의 쌍(pair)을 문자열(string)로 변환하여 출력하는 함수를 작성하세요.

 (단, 키(key)와 값(value) 사이에는 콜론(:)을, 쌍(pair) 사이에는 쉼표(,)를 넣어야 한다.)
 */
func dictToString(dict: [String: Any]) -> String {
	return dict.map { (key, value) in "\(key):\(value)" }.joined(separator: ",")
}

let dict4: [String: Any] = ["name": "Alice", "age": 20, "gender": "female"]
let result3 = dictToString(dict: dict4)
print(result3)       // age:20,gender:female,name:Alice

/*
 딕셔너리 예제 05
 다음과 같은 딕셔너리가 주어졌을 때, 모든 키(key)의 합(sum)과 모든 값(value)의 합(sum)을 각각 구하여 튜플(tuple)로 반환하는 함수를 작성하세요.
 */
func sumOfKeysAndValues(dict: [Int: Int]) -> (Int, Int) {
	return dict.reduce(into: (Int(), Int())) {
		$0.0 += $1.key
		$0.1 += $1.value
	}
}

let dict5 = [1: 10, 2: 20, 3: 30]
let result = sumOfKeysAndValues(dict: dict5)
print(result)       // (6, 60)
