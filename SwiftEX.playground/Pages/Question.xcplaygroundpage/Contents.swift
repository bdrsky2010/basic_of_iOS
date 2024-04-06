import Foundation

/**
 # 궁금한 것이 생겼을 때 해결하기 위한 페이지입니다.
 */

/**
 # Swift 배열의 Capacity
 Swift에서 사용되는 배열은
 .insert(_:at:) 혹은 .append(_:)
 작업을 대비하기 위해 특정 양의 메모리를 미리 할당한다
 
 배열에 원소를 추가할 때 해당 배열이 사용하고 있는 메모리의 총량(capacity)이 넘어가면
 배열은 더 큰 메모리 영역을 할당하고 배열이 복사되며 원소가 추가된다
 */
var array: [Int] = [1]
array.count
array.capacity

array.append(2)
array.count
array.capacity

array.append(contentsOf: [3, 3])
array.count
array.capacity

array.append(4)
array.count
array.capacity

/*
 배열의 capacity를 확인해보면 capacity를 초과해서 append되는 경우
 기존 capacity의 2배 만큼의 메모리를 재할당하는 것을 볼 수 있다
 
 그 이유는, c++의 vector, JAVA의 ArrayList 등
 여러 프로그래밍 언어에서 사용되는 데이터구조인 동적배열에서는
 amortized constant-time performance 라는 전략을 사용한다.
 
 정확히는 알고리즘의 시간복잡도를 분석하여 알고리즘의 성능에 영향을 미치는
 요인 모두를 분석하여 효율적인 알고리즘을 구현하기 위한 전략으로
 
 이는 배열의 크기를 두배씩 잡아 Copy와 Write연산을 줄여 효율적으로
 동적할당하여 재할당 빈도수를 줄이기 위한 전략이다.
 */

/*
 .reserveCapacity(_:)
 말 그대로 배열의 capacity를 미리 예약해두는 메서드이다
 만약 사용될 데이터의 총량을 미리 알 수 있는 경우
 미리 배열에서 사용할 메모리 공간을 예약 할당하여
 초과할당을 방지할 수 있다.
 */
var numbers: [Int] = []
numbers.reserveCapacity(50)
numbers.capacity

/*
 하지만 .reserveCapacity(_:) 메서드는
 빈 배열에서만 사용을 해야하며 2번 이상 해당 메서드를 호출 시에는
 앱 자체의 성능 즉, 속도가 느려질 수 있다.
 
 amortized run time의 시간복잡도는 O(1)이고
 .reserveCapacity(_:)의 시간복잡도는 O(n)이기 때문에
 
 결론은 배열 선언 시 처음에 할당될 사이즈를 알고 있다면 사용해도되지만
 그게 아니라면 append하면서 기하학적으로 하
 */

/**
 # 걸리는 시간 테스트
 여러 연산이 이루어진 후 문자열을 출력해줘야하는 문제가 있다고 가정을 해보겠다.
 부득이하게 문자열을 문자열의 배열 형태로 연산이 이루어지다가
 마지막에 문자열의 형태로 출력을 해줘야 하는 상황에서
 내가 생각한 생각은
 '출력할 때 print(_ items, termination: "")의 형태로 출력을 해준다면 문자열을 출력한 것처럼 보여질 것이다'  였다.
 문제의 정답은 맞았지만 문득 나는 궁금해졌다.
 그렇다면 시간 상으로는 문자열 처럼 보여지게 출력하는 것과 문자열로 타입을 변환해주는 것
 이 둘중에 어떤 것이 더 빠를까? 라는 것이 궁금했던 것이고 나는 해당 생각을 토대로 시간을 계산해봤다.
 결과는 문자열로 변환해서 출력해주는 것이 빨랐지만 너무나도 확연한 차이를 보여줬다는 것이다.
 문자열 처럼 보여지게 출력을 하려면 반복문을 돌면서 계속 print() 함수를 호출해줘야 하기에
 시간 차이가 나는 것이 아닐까 라는 생각이 든다.
 다음부터는 앱을 개발하던, 알고리즘 문제를 풀던 문자열로 변환 후 진행해야겠다.
 */
let arr = Array(repeating: "a", count: 10000)
let clock = ContinuousClock()
let test1 = clock.measure {
	arr.forEach {
		print($0, terminator: "")
	}
}
print()
let test2 = clock.measure {
	print(arr.joined())
}

print("test1 :: \(test1)")
print("test2 :: \(test2)")
