//
//  ViewController.swift
//  Frame-Bounds
//
//  Created by Minjae Kim on 10/29/23.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var firstView: UIView!
	@IBOutlet weak var secondView: UIView!
	@IBOutlet weak var thirdView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print("frame & bounds\n")
		
		/*
		 frame의 origin(x, y)
		 frame이 나타내는 origin(x, y)좌표는
		 Super View의 원점을 (0, 0)으로 놓고
		 원점으로부터 얼마나 떨어져 있는지를 나타낸 것
		 */
		print("frame :: origin and size")
		print(firstView.frame.origin, firstView.frame.size)
		print(secondView.frame.origin, secondView.frame.size)
		print(thirdView.frame.origin, thirdView.frame.size)
		print()
		
		/*
		 bounds의 origin(x, y)
		 bounds의 좌표계는 frame과 달리
		 Super View와는 아무 상관이 없으며 자기 자신이 기준
		 자신의 원점을 (0, 0)으로 초기화
		 */
		print("bounds :: origin and size")
		print(firstView.bounds.origin, firstView.bounds.size)
		print(secondView.bounds.origin, secondView.bounds.size)
		print(thirdView.bounds.origin, thirdView.bounds.size)
		print()
		
		print("firstView rotate angle 100")
		firstView.transform = .init(rotationAngle: 100)
		
		/*
		 frame의 size(width, height)
		 frame의 size는 View 영역을 모두 감싸는 사각형으로
		 나타낸 것
		 view를 rotate 한 후 확인해보면
		 frame의 origin(x, y) 값, size(width, height)값이
		 변한 것을 확인할 수 있다.
		 frame의 size는 View 자체의 크기가 아닌
		 View가 차지하는 영역을 감싸서 만든 사각형의 크기가
		 바로 frame의 size인 것이다.
		 */
		print("frame :: origin and size")
		print(firstView.frame.origin, firstView.frame.size)
		print(secondView.frame.origin, secondView.frame.size)
		print(thirdView.frame.origin, thirdView.frame.size)
		print()
		
		/*
		 bounds의 size(width, height)
		 bounds의 size는 View 자체의 영역을 나타낸 것
		 아무리 View를 회전시킨다고 한들 bounds의 size는
		 변하지 않는다.
		 bounds는 View 자체의 영역을 나타내기 때문이다
		 또한 origin도 변하지 않는다.
		 */
		print("bounds :: origin and size")
		print(firstView.bounds.origin, firstView.bounds.size)
		print(secondView.bounds.origin, secondView.bounds.size)
		print(thirdView.bounds.origin, thirdView.bounds.size)
		print()
		
		firstView.transform = .init(rotationAngle: 0)
		/*
		 secondView의 bounds origin(x, y)값을 변경해보니
		 secondView가 움지이는 것이 아닌
		 thirdView가 움직이는 것을 확인할 수 있었다.
		 이유는, Sub View가 반대 좌표로 가는 것이 아닌
		 View가 Sub View를 바라보는 시점(viewport)가
		 달라졌기 때문이다.
		 */
		secondView.bounds.origin = .init(x: 50, y: 50)
		
		/*
		 clipsToBounds의 default는 false 인데
		 Super View를 Sub View가 넘어갈 시에
		 이걸 Super View 너머로 그릴 것인 지에 대해
		 결정한다.
		 false면 넘어가는 것이고
		 true면 넘기지 않는 것이다.
		 */
		secondView.clipsToBounds = true
		
		print("bounds :: modify origin(x: 50, y: 50)")
		print("bounds :: origin and size")
		print(firstView.bounds.origin, firstView.bounds.size)
		print(secondView.bounds.origin, secondView.bounds.size)
		print(thirdView.bounds.origin, thirdView.bounds.size)
		print()
	}
}

