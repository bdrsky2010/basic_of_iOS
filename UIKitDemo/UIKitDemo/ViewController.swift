//
//  ViewController.swift
//  UIKitDemo
//
//  Created by Minjae Kim on 11/10/23.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var helloLabel: UILabel!
	@IBOutlet weak var nameTextfield: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func tabSendButton(_ sender: UIButton) {
		helloLabel.text = "Hello " + (nameTextfield.text ?? "")
	}
	
}

