import Foundation

/*
 제너릭 예제 01
 다음 코드에서 컴파일 에러가 발생하는 이유를 설명하고, Generics을 사용하여 에러를 해결하는 방법을 제시하세요.
 
 // 예시 코드:
 struct Stack {
		 var items = [Int]()
		 mutating func push(_ item: Int) {
				 items.append(item)
		 }
		 mutating func pop() -> Int {
				 return items.removeLast()
		 }
 }

 var intStack = Stack()
 intStack.push(3)
 intStack.push(5)
 print(intStack.pop()) // 5

 var stringStack = Stack()
 stringStack.push("Hello")
 stringStack.push("World")
 print(stringStack.pop())
 */

/*
 Solution
 
 struct Stack<T> {
		 var items = [T]()
		 mutating func push(_ item: T) {
				 items.append(item)
		 }
		 mutating func pop() -> T {
				 return items.removeLast()
		 }
 }

 var intStack = Stack<Int>()
 intStack.push(3)
 intStack.push(5)
 print(intStack.pop()) // 5

 var stringStack = Stack<String>()
 stringStack.push("Hello")
 stringStack.push("World")
 print(stringStack.pop())
 */

/*
 제너릭 예제 02
 제너릭 함수로 두 개의 값을 교환하는 swap 함수를 작성해보세요.
 */
func swap<T>(_ a: inout T, _ b: inout T) {
	(a, b) = (b, a)
}
var (a, b): (Int, Int) = (23, 44774484)
swap(&a, &b)
print(a, b)

/*
 제너릭 예제 03
 제너릭 타입으로 스택을 구현해보세요.

 스택은 push, pop, peek, isEmpty 등의 메서드를 가지고 있어야 합니다.
 */
struct Stack<T> {
	// 스택을 선형 형태로 저장하기 위한 저장 프로퍼티
	var stack: [T] = []
	
	// 스택의 사이즈를 계산해주는 연산 프로퍼티
	var count: Int {
		return stack.count
	}
	// 스택이 비어있는 지 참,거짓을 반환해주는 프로퍼티
	var isEmpty: Bool {
		return stack.isEmpty
	}
	
	// 스택의 모든 원소를 삭제하는 메서드
	mutating func clear() {
		stack.removeAll()
	}
	
	// 스택의 top에 값을 추가해주는 메서드
	mutating func push(_ el: T) {
		stack.append(el)
	}
	
	// 스택의 top 원소를 지우면서 값을 반환해주는 메서드
	mutating func pop() -> T? {
		return stack.popLast()
	}
	
	// 스택의 top 원소의 값을 반환해주는 메서드
	func peek() -> T? {
		return stack.last
	}
}

var stack = Stack<Int>()
stack.push(2)
stack.push(3)
stack.push(4)
print(stack)
print(stack.count)
print(stack.isEmpty)
print(stack.pop() ?? 0)
print(stack.peek() ?? 0)
stack.clear()
print(stack.isEmpty)

/*
 제너릭 예제 04
 제너릭 타입으로 큐를 구현해보세요.

 큐는 enqueue, dequeue, front, isEmpty 등의 메서드를 가지고 있어야 합니다.
 */
struct Queue<T> {
	// Queue를 선형 형태로 저장하는 프로퍼티
	private var queue: [T] = []
	
	// Queue 크기를 반환하는 프로퍼티
	public var count: Int {
		return queue.count
	}
	
	// Queue가 비어있는지 유무를 반환하는 프로퍼티
	public var isEmpty: Bool {
		return queue.isEmpty
	}
	
	// Queue의 첫 원소를 반환하는 메서드
	func front() -> T? {
		return queue.first
	}
	
	// Queue의 원소 전체 삭제 메서드
	mutating func clear() {
		queue.removeAll()
	}
	
	// Queue의 마지막에 원소를 추가하는 메서드
	mutating func enqueue(_ el: T) {
		queue.append(el)
	}
	
	// Queue의 첫 원소를 삭제 후 반환하는 메서드
	mutating func dequeue() -> T? {
		return isEmpty ? nil : queue.removeFirst()
	}
}

var queue = Queue<String>()
queue.enqueue("A")
queue.enqueue("B")
queue.enqueue("C")
print(queue.dequeue()) // A
print(queue.front()) // B
print(queue.isEmpty) // false

/*
 제너릭 예제 05
 다음의 함수는 제네릭 타입 T를 인자로 받아서 T의 타입을 출력하는 함수입니다.

 제네릭을 이용하여 함수를 완성하세요.
 */
func printType<T>(_ input: T) {
	print("The type of \(input) is \(T.self) ")
}

printType(3) // The type of 3 is Int
printType("Hello") // The type of Hello is String
printType(true) // The type of true is Bool

/*
 제너릭 예제 06
 다음의 클래스는 제네릭 타입 Key와 Value를 가지는 Node 클래스입니다.

 제네릭을 이용하여 클래스를 완성하세요.
 */
class Node2<Key, Value> {
	var key: Key
	var value: Value
	
	init(key: Key, value: Value) {
		self.key = key
		self.value = value
	}
}

let node = Node2(key: "name", value: "Alice")
print(node.key) // name
print(node.value) // Alice

/*
 제너릭 예제 07
 다음의 함수는 두 개의 제네릭 타입 두 개의 인자를 받아서 두 값이 같은지 비교하는 함수입니다.

 제네릭을 이용하여 함수를 완성하세요.
 */

func isEqual<T: Equatable>(_ left: T, _ right: T) -> Bool {
	return left == right
}

print(isEqual(1, 1)) // true
print(isEqual("Hello", "World")) // false
print(isEqual(true, false)) // false

/*
 제너릭 예제 08
 다음의 함수는 제네릭 타입 T를 인자로 받아서 T의 타입이 Int인지 확인하는 함수입니다.

 제네릭을 이용하여 함수를 완성하세요.
 */
func isInt<T>(_ input: T) -> Bool {
	return input is Int
}

print(isInt(3)) // true
print(isInt("Hello")) // false
print(isInt(true)) // false

/*
 제너릭 예제 09
 다음의 함수는 제네릭 타입 T를 인자로 받아서 T의 타입을 Int로 캐스팅하는 함수입니다.

 제네릭을 이용하여 함수를 완성하세요.
 */
func castToInt<T>(_ input: T) -> Int? {
	return input as? Int
}

print(castToInt("3")) // 3
print(castToInt("Hello")) // nil
print(castToInt(true)) // nil

/*
 제너릭 예제 10
 다음의 함수는 제네릭 타입 T를 가지는 배열을 인자로 받아서 배열의 첫 번째 원소와 마지막 원소를 교환하는 함수입니다.

 제네릭을 이용하여 함수를 완성하세요.
 */
func swapFirstAndLast<T>(_ arr: inout [T]) {
	guard arr.count >= 2 else { return }
	(arr[0], arr[arr.count - 1]) = (arr[arr.count - 1], arr[0])
}

var array = [1, 2, 3, 4, 5]
swapFirstAndLast(&array)
print(array) // [5, 2, 3, 4, 1]

var array2 = ["A", "B", "C", "D"]
swapFirstAndLast(&array2)
print(array2) // ["D", "B", "C", "A"]

/*
 제너릭 예제 11
 다음의 함수는 제네릭 타입 T를 가지는 배열을 인자로 받아서 배열의 모든 원소를 역순으로 출력하는 함수입니다.

 제네릭을 이용하여 함수를 완성하세요.
 */
func printReverse<T>(_ arr: [T]) {
	arr.reversed().forEach { print($0) }
}

let array3 = [1, 2, 3, 4, 5]
printReverse(array3)
// 5
// 4
// 3
// 2
// 1

let array4 = ["A", "B", "C", "D"]
printReverse(array4)
// D
// C
// B
// A

/*
 제너릭 예제 12
 제너릭 타입으로 연결 리스트를 구현해보세요.

 연결 리스트는 append, insert, remove, nodeAt 등의 메서드를 가지고 있어야 합니다.
 */
enum AccessError: Error {
	case outOfRange
}

class Node<T> {
	public var value: T
	public var next: Node?
	
	init(_ value: T) {
		self.value = value
	}
}

struct LinkedList<T: Equatable> {
	private var head: Node<T>?
	init(head: Node<T>? = nil) {
		self.head = head
	}
	
	public var count: Int {
		var cnt: Int = 0
		if head == nil {
			return cnt
		}
		
		var node: Node? = head
		cnt += 1
		while node?.next != nil {
			cnt += 1
			node = node?.next
		}
		return cnt
	}
	
	mutating func append(_ element: T) {
		if head == nil {
			self.head = Node(element)
			return
		}
		
		var node: Node? = head
		while node?.next != nil {
			node = node?.next
		}
		node?.next = Node(element)
	}
	
	private func rangeOverIndex(_ index: Int) throws {
		guard index <= count - 1 else { throw AccessError.outOfRange }
	}
	
	mutating func insert(_ element: T, at index: Int) {
		do {
			try rangeOverIndex(index)
			if index == 0 {
				let newNode: Node = Node(element)
				newNode.next = head
				head = newNode
				return
			}
			
			var node = head
			for _ in 0..<(index - 1) {
				if node?.next == nil { break }
				node = node?.next
			}
			
			let newNode: Node = Node(element)
			newNode.next = node?.next
			node?.next = newNode
			
		} catch AccessError.outOfRange {
			print("Fatal error: Index out of range")
		} catch {
			print("Fatal error: Unknown Access")
		}
	}
	
	mutating func remove(at index: Int) {
		guard head != nil else { return }
		do {
			try rangeOverIndex(index)
			
			if index == 0 {
				head = head?.next
			}
			var node: Node? = head
			for _ in 0..<(index - 1) {
				if node?.next?.next == nil { break }
				node = node?.next
			}
			
			node?.next = node?.next?.next
			
		} catch AccessError.outOfRange {
			print("Fatal error: Index out of range")
		} catch {
			print("Fatal error: Unknown Access")
		}
	}
	
	func nodeAt(_ index: Int) -> Node<T>? {
		guard head != nil else { return nil }
		var node: Node? = head
		for i in 0...count - 1 {
			if i == index { break }
			node = node?.next
		}
		return node
	}
}

var list = LinkedList<Int>()
list.append(1)
list.append(2)
list.append(3)
list.insert(4, at: 1)
list.remove(at: 1)
print(list.nodeAt(0)?.value) // 1
print(list.nodeAt(1)?.value) // 4
print(list.nodeAt(2)?.value) // 3
