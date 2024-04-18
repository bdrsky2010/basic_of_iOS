import Foundation

/*:
 ## 📚 Any

 - Any 타입은 기본 타입(Int, String, Double, Bool 등등), class, struct, enum, function 까지 모두 포함하여 어떤 타입의 인스턴스도 표현할 수 있는 타입을 말합니다. 옵셔널타입도 포함됩니다.
 - 즉, 내가 변수에 어떠한 타입이 들어올 지 모르거나 혹은 계속해서 서로 다른 타입의 데이터가 들어온다거나 혹은 배열에 여러 타입을 담아줘야 하는 경우에 사용을 할 수 있는 것이라고 생각이 됩니다.
 */

var dontKnowDataType: Any = "Timmy" // String
dontKnowDataType = 2147483647 // Int
dontKnowDataType = false // Bool

/*:
 - 위에서 말했듯이 여러 타입을 가질 수 있는 배열을 만들어줄 수도 있습니다.
 */

class Me {
	var name = "Timmy"
	var age = 30
}

var dontKnowArr: [Any] = [2147483647, "Timmy", Me(), {(name: String) in return name}]

/*:
 하지만 불편함 점은 역시나 존재합니다.
 
 꼭 좋은 것만 얻을 순 없는 것이니까요.
 
 그것이 코딩이니까..!!
 
 불편한 점은 저장된 타입의 메모리 구조를 알 수 없기 때문에, 항상 타입캐스팅을 해줘야 하는 점입니다.
 여기서 또 왜 저장된 타입은 메모리 구조를 알 수 없을까 라는 궁금이 생깁니다.

 > **🔥 왜 Any 타입은 저장된 타입의 메모리 구조를 모르는가?**
 >
 > 실제 원본 데이터는 형태에 따라 메모리의 위치가 정해지기 때문에 실제 데이터가 스택에 저장될 지, 힙에 저장이 될 지 알 수가 없습니다. 왜냐, 기본 데이터 타입, 구조체 같은 친구들은 Value 타입이라 스택에 저장이 되고(보통은 스택 메모리에 저장이 되지만 크기가 너무 큰 데이터의 경우 힙 메모리에 저장될 수 있음), class는 Reference 타입이기 때문에 힙에 저장이 되기 때문입니다. 결론적으로 Any 자체는 해당 데이터에 접근만 가능하도록 이뤄져있습니다.
 */

print(dontKnowArr[0] as! Int)
print(dontKnowArr[1] as! String)
print((dontKnowArr[2] as! Me).name)

/*:
 근데 또, 여기서 궁금증이 생겨요...
 무엇이냐면, as라는 키워드는 타입캐스팅 연산자입니다. 근데 제가 알기로는 타입캐스팅이라는 키워드는 Swift의 OOP의 개념인 상속성에서 나오는 개념이구요.
 그렇다면 Swift에서 기본 데이터타입인 Int, String, Double 등등 이 친구들은 살펴보면 struct 즉, 구조체로 선언되어 있는 친구들입니다. 맞습니다. 구조체는 상속을 하거나 받을 수가 없는 친구에요.

 > **🔥 기본 데이터 타입은 구조체인데 타입캐스팅이 가능할까?**
 >
 > 결론적으로는 Swift는 Up/Down 캐스팅되는 방식이 좀 다르게 구현되어 있습니다. 타입 캐스팅의 개념은 상속뿐 아니라 Protocol에서도 타입 캐스팅의 개념이 적용됩니다. 즉, Protocol을 채택한 타입이 있다면 Protocol과 Protocol을 채택한 타입의 관계에서도 타입캐스팅이 가능한겁니다.
 >
 > 근데 웃긴건 Any 타입은 Protocol도 아니라는 사실!
 > 다음에 설명할 AnyObject의 경우는 Protocol이 맞습니다. Swift에서는 모든 class가 AnyObject Protocol을 암시적으로 무조건 채택하도록 구현이 되어있습니다. Any 타입은 Swift에서 **자체로 특별한 타입으로 정의되어 있습니다.** 특별한 타입으로 구현되어 스위프트에서 다루는 모든 타입으로도 타입캐스팅이 가능합니다. 그냥 Protocol의 관점으로 봐도 무방해보입니다.

 ## 📚 AnyObject

 - 어떤 클래스 타입의 인스턴스를 표현할 수 있는 타입입니다.
 - 즉, Any 타입 마냥 기본 데이터타입, 구조체, 열거형은 못담고 class만 담을 수 있는 겁니다.
 - 위에서 말했듯이 AnyObject는 Protocol로 구현되어 있습니다.
 - Any와 동일하게 데이터에 접근하기위해서는 타입캐스팅을 해줘야 합니다.
 */

class Me {
	var name = "Timmy"
	var age = 30
}

  

class Book {
	var name = "책책"
	var author = "Timmy"
	var publisher = "마이크로폰책"
	var date = Date()
}

  

let whatAnyObjectArr: [AnyObject] = [Me(), Book(),
									 NSString("나랑 같이 놀래? 재밌겠다")]
									 
print((whatAnyObjectArr[0] as! Me).name) // Timmy
print((whatAnyObjectArr[1] as! Book).publisher) // 마이크로폰책
print(whatAnyObjectArr[2]) // 나랑 같이 놀래? 재밌겠다

/*:
 > **🔥 번외편**
 >
 > 보다보니 이상한 것이 또 있죠?
 > NSString 타입이 쌩뚱맞게 배열에 들어가있습니다.
 > 어쨌든 Swift는 Objective C언어를 기반으로 만들어진 언어다보니 어쩔 수 없이 Objective C를 사용할 수밖에 없을 때도 있어서 Foundation 을 import하면 사용할 수 있습니다.
 > NSString도 어쨌든 타입이 아닌가요? 라고 저는 생각했고 찾아보니 NSString, NSNumber 등 Objective C에서 사용되는 기본 데이터 타입들은 class로 구현이 되어있었습니다.
 */
