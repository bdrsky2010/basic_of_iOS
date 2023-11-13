//
//  SecondViewController.swift
//  AutolayoutExample-1
//
//  Created by Minjae Kim on 11/13/23.
//

import UIKit

class SecondViewController: UIViewController {

	@IBOutlet weak var image_1: UIImageView!
	@IBOutlet weak var image_2: UIImageView!
	@IBOutlet weak var image_3: UIImageView!
	@IBOutlet weak var image_4: UIImageView!
	@IBOutlet weak var image_5: UIImageView!
	@IBOutlet weak var image_6: UIImageView!
	@IBOutlet weak var image_7: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		let images = [image_1, image_2, image_3, image_4, image_5, image_6, image_7]
		(0..<images.count).forEach {
			images[$0]?.layer.cornerRadius = (images[$0]?.frame.height ?? 1) / 2
		}
    }

}
