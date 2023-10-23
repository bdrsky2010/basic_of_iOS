import Foundation

extension Array {
	func mapp<T>(_ transform: (Int) -> T) -> [T] {
		var result: [T] = []
		for num in self {
			result.append(transform(num as! Int))
		}
		return result
	}
	
	func reducee(_ initialResult: Int, _ nextPartialResult: (Int, Int) -> Int) -> Int {
		var initialResult: Int = initialResult
		self.forEach { element in
			initialResult = nextPartialResult(initialResult, element as! Int)
		}
		return initialResult
	}
	
	func filterr(_ isIncluded: (Int) -> Bool) -> [Int] {
		var result: [Int] = []
		for num in self {
			if isIncluded(num as! Int) { result.append(num as! Int) }
		}
		return result
	}
	
	func forEachh(_ body: (Int) -> Void) {
		for num in self {
			body(num as! Int)
		}
	}
}
var a = [1,2,3,4,5,6,7,8,9,10]
print(a.mapp { String($0) + "번이다" })
print(a.reducee(1, *))
print(a.filterr { $0 % 2 == 0 })
