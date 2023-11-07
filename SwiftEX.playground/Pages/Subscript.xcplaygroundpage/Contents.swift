import Foundation

/*
 서브스크립트(Subscripts)
 콜렉션의 요소에 접근
 
 서브스크립트(Subscripts)는 클래스, 구조체, 열거형의 콜렉션/리스트/시퀀스의 멤버 요소에 접근할 수 있는 단축표현
 설정과 검색을 위한 별도의 메서드 없이 인덱스로 값을 설정하고 조회하기 위해 서브 스크립트를 사용
 
 예) someArray[index] 로 Array 인스턴스에 요소를 접근하고 someDictionary[key] 로 Dictionary 인스턴스에 요소를 접근
 */

struct MySubscripts {
	var arr: [String] = []
	
	subscript(index: Int) -> String {
		get { return arr[index] }
		set { arr[index] = newValue }
	}
}

var mysc = MySubscripts(arr: ["Park", "Kim", "Lee"])
mysc[1]
mysc[1] = "Minjae"
mysc[1]

//extension String {
//	subscript (reCount: Int) -> String {
//		var str = ""
//		for _ in 0..<reCount {
//			str += self
//		}
//		return str
//	}
//}
//print( "Hello"[5] )

extension String {
	subscript(index: Int) -> Character? {
		guard index < self.count else { return nil }
		return self[self.index(self.startIndex, offsetBy: index)]
	}
	
	subscript(range: Range<Int>) -> String {
		let start = self.index(self.startIndex, offsetBy: range.startIndex)
		let end = self.index(self.startIndex,offsetBy: range.endIndex)
		
		return String(self[start..<end])
	}
	
	// 1..<5 는 Range 타입
	// 1...5 는 ClosedRange 타입
	subscript(range: ClosedRange<Int>) -> String {
		// ClosedRange 를 Range 타입으로 변환
		let range = range.first!..<range.count
		
		let start = self.index(self.startIndex, offsetBy: range.startIndex)
		let end = self.index(self.startIndex,offsetBy: range.endIndex)
		
		return String(self[start...end])
	}
}
print("minjae"[2] ?? "")

var str: String = "helloSwift"
print(str[1..<5])
print(str[1...5])
