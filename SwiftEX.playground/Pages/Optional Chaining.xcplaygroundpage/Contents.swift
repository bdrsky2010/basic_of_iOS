import Foundation

/*
 옵셔널 체이닝 (Optional Chaining)
 
 Force unwrapping : ! 강제로 옵셔널 추출
 Optional Binding : if let, guard let 바인딩하여 옵셔널 추출
 Optional Chaining: ?.?.?. 체인 형태(연쇄적)로 옵셔널에 접근하여 추출
 
 언래핑(강제추출) 없이 옵셔널 값의 접근
	- 옵셔널 바인딩하고 비슷
	- 코드 간결의 장점
 */

 
/*
 옵셔널로 residence 프로퍼티를 '체인'하고 residence 가 존재하면 numberRooms을 조회
 
 class Residence {
	 var numberRooms = 1
 }

 class Person {
	 var residence: Residence?
 }

 let park = Person()
 //let roomNumber = park.residence!.numberRooms  // 강제 언레핑 이용시 runtime error
 park.residence = Residence()

 if let roomNumber = park.residence?.numberRooms {
	 print(roomNumber)
 } else {
	 print("Not!! roomNumber")
 }
 */

/*
 옵셔널 체이닝을 통해 프로퍼티에 접근
 park 인스턴스를 Person의 옵셔널 형태로 생성했으므로 park 인스턴스에 ? 을 붙여서 옵셔널이라는 것을 알려주어야 오류가 없음
 
 struct Contacts {
	 var email : String
	 var address : [String:String]
 }

 struct Person {
	 var name : String
	 var contacts: Contacts?
	 
	 init(name: String, email: String, address: String) {
		 self.name = name
		 self.contacts = Contacts(email: email, address: ["home": address])
	 }
 }

 var park : Person? = Person(name: "park", email: "oz@test.com", address: "No!")

 park?.name
 //park?.contacts = nil

 if let email = park?.contacts?.email {
		 print(email)
 } else {
		 print("No email")
 }
 */

/*
 옵셔널 체이닝 예제 01
 다음 코드에서 person의 name과 age를 출력하려고 합니다.

 옵셔널 체이닝을 사용하여 코드를 완성하세요.
 */
struct Person {
		var name: String?
		var age: Int?
}

var person: Person? = Person(name: "Kim", age: 25)

print(person?.name)
print(person?.age)

if let name = person?.name, let age = person?.age {
	print()
	print(name)
	print(age)
}

/*
 옵셔널 체이닝 예제 02
 다음 코드에서 book의 title과 book.author의 name을 출력하려고 합니다.

 옵셔널 체이닝을 사용하여 코드를 완성하세요.
 */
struct Author {
	var name: String?
}

struct Book {
	var title: String?
	var author: Author?
}

var book: Book? = Book(title: "The Little Prince", author: Author(name: "Antoine de Saint-Exupéry"))

print(book?.title)              // The Little Prince
print(book?.author?.name)       // Antoine de Saint-Exupéry

if let title = book?.title, let name = book?.author?.name {
	print()
	print(title)
	print(name)
}

/*
 옵셔널 체이닝 예제 03
 다음 코드에서 numbers 배열의 첫번째 원소에 10을 더한 값을 출력하려고 합니다.

 옵셔널 체이닝을 사용하여 코드를 완성하세요.
 */
var numbers: [Int]? = [1, 2, 3]

print((numbers?[0] ?? 0) + 10)

/*
 옵셔널 체이닝 예제 04
 다음 코드에서 students 딕셔너리의 "Lee" 키에 해당하는 값에 1을 더한 값을 출력하려고 합니다.

 옵셔널 체이닝을 사용하여 코드를 완성하세요.
 */
var students: [String: Int]? = ["Kim": 90, "Lee": 80, "Park": 85]

print((students?["Lee"] ?? 0) + 1)

/*
 옵셔널 체이닝 예제 05
 다음 코드에서 animal의 speak 메서드를 호출하려고 합니다.

 옵셔널 체이닝을 사용하여 코드를 완성하세요.
 */
class Animal {
	func speak() {
		print("...")
	}
}

class Dog: Animal {
	override func speak() {
		print("Woof")
	}
}

var animal: Animal? = Dog()
animal?.speak()

/*
 옵셔널 체이닝 예제 06
 다음 코드에서 matrix의 transpose 메서드를 호출하여 결과를 출력하려고 합니다.

 옵셔널 체이닝을 사용하여 코드를 완성하세요.
 */
struct Matrix {
	var elements: [[Int]]
	
	func transpose() -> Matrix {
		var result = [[Int]]()
		for i in 0..<elements[0].count {
			var row = [Int]()
			for j in 0..<elements.count {
				row.append(elements[j][i])
			}
			result.append(row)
		}
		return Matrix(elements: result)
	}
}

var matrix: Matrix? = Matrix(elements: [[1, 2, 3], [4, 5, 6]])
print(matrix?.transpose().elements)

if let elements = matrix?.transpose().elements {
	print()
	print(elements)
}

/*
 옵셔널 체이닝 예제 07
 다음 코드에서 옵셔널 체이닝을 이용하여 numbers 배열의 모든 요소를 더한 값을 출력하세요.

 numbers가 nil이면 0을 출력하세요.
 */
var numbers2: [Int]? = [1, 2, 3, 4, 5]
print(numbers2?.reduce(0, +) ?? 0)

/*
 옵셔널 체이닝 예제 08
 다음 코드에서 옵셔널 체이닝을 이용하여 students 배열의 모든 요소의 score 속성의 평균값을 출력하세요.

 students가 nil이거나 비어있으면 0을 출력하세요.
 */
struct Student {
	var name: String
	var score: Int
}

var students2: [Student]? = [Student(name: "Kim", score: 80),
														 Student(name: "Lee", score: 90),
														 Student(name: "Park", score: 85)]
if let sum = (students2?.reduce(0) { $0 + $1.score }), let count = students2?.count, count != 0 {
	print(sum / count)
} else {
	print(0)
}
