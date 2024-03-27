//
//  ViewController.swift
//  DatabaseDemo
//
//  Created by Minjae Kim on 11/22/23.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var address: UITextField!
	@IBOutlet weak var phone: UITextField!
	@IBOutlet weak var status: UILabel!
	
	var databasePath = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initDB()
	}
	 // 데이터베이스 초기화
	func initDB() {
		let fileMgr = FileManager.default
		let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
		
		databasePath = dirPaths[0].appendingPathExtension("contacts.db").path
		
		if !fileMgr.fileExists(atPath: databasePath) {
			let contactDB = FMDatabase(path: databasePath)
			if contactDB.open() {
				status.text = "열렸다"
				let sql_stmt = "create table if not exists contacts (id integer primary key autoincrement, name text, address text, phone text)"
				if !contactDB.executeStatements(sql_stmt) {
					print("Error: \(contactDB.lastErrorMessage())")
				}
				contactDB.close()
			} else {
				print("Error: \(contactDB.lastErrorMessage())")
			}
		} else {
			status.text = "파일 있다"
		}
	}
	
	@IBAction func saveContact(_ sender: UIButton) {
		let fileMgr = FileManager.default
		let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
		
		databasePath = dirPaths[0].appendingPathExtension("todo.db").path
		
		let contactDB = FMDatabase(path: databasePath)
		if contactDB.open() {
			let sql = "insert into contacts (name, address, phone) values ('\(name.text ?? "")', '\(address.text ?? "")', '\(phone.text ?? "")')"
			do {
				try contactDB.executeUpdate(sql, values: nil)
			} catch {
				status.text = "contact 추가 실패"
			}
			status.text = "Contact Added"
			name.text = ""
			address.text = ""
			phone.text = ""
			contactDB.close()
		} else {
			status.text = "DB Open 오류 발생"
			print("Error: \(contactDB.lastErrorMessage())")
		}
	}
	
	@IBAction func findContact(_ sender: UIButton) {
		let contactDB = FMDatabase(path: databasePath)
		if contactDB.open() {
			let sql = "select name, address, phone from contacts where name='\(name.text ?? "")'"
			
			do {
				
				let results: FMResultSet? = try contactDB.executeQuery(sql, values: nil)
				
				if results?.next() == true {
					address.text = results?.string(forColumn: "address")
					phone.text = results?.string(forColumn: "phone")
					status.text = "Record Found"
				} else {
					status.text = "Record Not Found"
					address.text = ""
					phone.text = ""
				}
				
			} catch {
				print("Error: \(contactDB.lastErrorMessage())")
			}
			
			contactDB.close()
			
		} else {
			status.text = "DB Open Failed"
			print("Error: \(contactDB.lastErrorMessage())")
		}
	}
}

