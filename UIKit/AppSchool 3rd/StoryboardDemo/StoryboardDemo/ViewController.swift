//
//  ViewController.swift
//  StoryboardDemo
//
//  Created by Minjae Kim on 11/15/23.
//

import UIKit

class ViewController: UIViewController {
	
	
	@IBOutlet weak var imageView: UIImageView!
	var images: [String] = ["teletobi.jpeg", "spider.jpeg", "pat-mat-03.jpeg"]
	var imgWidth: CGFloat = 300
	var imgHeight: CGFloat = 200
	var isSwitching: Bool = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.frame.size = CGSize(width: imgWidth, height: imgHeight)
	}
	
	@IBAction func tabImgChangeButton(_ sender: UIButton) {
		imageView.image = UIImage(named: images[(0...2).randomElement() ?? 0])
	}
	@IBAction func switchingImgSize(_ sender: UISwitch) {
		if sender.isOn {
			imageView.frame.size = CGSize(width: imgWidth, height: imgHeight)
		} else {
			let halfWidth = imageView.frame.width / 2
			let halfHeight = imageView.frame.height / 2
			
			imageView.frame.size = CGSize(width: halfWidth, height: halfHeight)
		}
	}
}

