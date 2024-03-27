//
//  NaverWebtoonViewController.swift
//  AutoLayout
//
//  Created by Minjae Kim on 11/1/23.
//

import UIKit

class NaverWebtoonViewController: UIViewController {
	@IBOutlet weak var topImageLabel: UIImageView!
	@IBOutlet weak var weekStackView: UIStackView!
	
	@IBOutlet weak var imageView1: UIImageView!
	@IBOutlet weak var imageView2: UIImageView!
	@IBOutlet weak var imageView3: UIImageView!
	@IBOutlet weak var imageView4: UIImageView!
	@IBOutlet weak var imageView5: UIImageView!
	@IBOutlet weak var imageView6: UIImageView!
	@IBOutlet weak var imageView7: UIImageView!
	@IBOutlet weak var imageView8: UIImageView!
	@IBOutlet weak var imageView9: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		topImageLabel.image = .bear
		topImageLabel.contentMode = .scaleAspectFill
		
		imageView1.image = ._1
		imageView1.contentMode = .scaleAspectFill
		
		imageView2.image = ._2
		imageView2.contentMode = .scaleAspectFill
		
		imageView3.image = ._3
		imageView3.contentMode = .scaleAspectFill
		
		imageView4.image = ._4
		imageView4.contentMode = .scaleAspectFill
		
		imageView5.image = ._5
		imageView5.contentMode = .scaleAspectFill
		
		imageView6.image = ._6
		imageView6.contentMode = .scaleAspectFill
		
		imageView7.image = ._7
		imageView7.contentMode = .scaleAspectFill
		
		imageView8.image = ._8
		imageView8.contentMode = .scaleAspectFill
		
		imageView9.image = ._9
		imageView9.contentMode = .scaleAspectFill
		
	}
}
