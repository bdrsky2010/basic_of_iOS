//
//  AddViewController.swift
//  DBExample
//
//  Created by Minjae Kim on 11/23/23.
//

import UIKit

class AddViewController: UIViewController {

	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var titleField: UITextField!
	@IBOutlet weak var contentField: UITextField!
	var databasePath = ""
	var stringDate = ""
	override func viewDidLoad() {
        super.viewDidLoad()
		datePicker.datePickerMode = .date
		// 언어 설정
		datePicker.locale = Locale(identifier: "ko-KR")
		
		// 현재 날짜
		let now = Date()
		// datePicker의 minimum을 오늘로 설정
		datePicker.minimumDate = now
		
		datePicker.preferredDatePickerStyle = .compact
		
		var dateFormmater = DateFormatter()
		dateFormmater.dateStyle = .medium // 날짜 디테일 정도 정해줌
		stringDate = dateFormmater.string(from: datePicker.date)
		hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
	@IBAction func saveTapButton(_ sender: UIButton) {
		let fileMgr = FileManager.default
		let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
		
		databasePath = dirPaths[0].appendingPathExtension("todolist.db").path
		
		let contactDB = FMDatabase(path: databasePath)
		if contactDB.open() {
			let sql = "insert into todolist (date, title, content) values ('\(stringDate)', '\(titleField.text ?? "")', '\(contentField.text ?? "")')"
			do {
				try contactDB.executeUpdate(sql, values: nil)
			} catch {
				dump("contact 추가 실패")
			}
			dump("Contact Added")
			datePicker.date = Date()
			titleField.text = ""
			contentField.text = ""
			contactDB.close()
		} else {
			dump("DB Open 오류 발생")
			dump("Error: \(contactDB.lastErrorMessage())")
		}
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension UIViewController {
	func hideKeyboard() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	@objc func dismissKeyboard() {
		view?.endEditing(true)
	}
}
