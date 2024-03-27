//
//  ViewController.swift
//  DBExample
//
//  Created by Minjae Kim on 11/23/23.
//

import UIKit

class ViewController: UITableViewController {
	
	let myData = ["사과", "바나나", "포도", "키위"]
	var dataIndex = 0
	var databasePath = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.estimatedRowHeight = 50
		initDB()
		loadDB()
	}
	
	// 데이터베이스 초기화
   func initDB() {
	   let fileMgr = FileManager.default
	   let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
	   
	   databasePath = dirPaths[0].appendingPathExtension("todolist.db").path
	   
	   if !fileMgr.fileExists(atPath: databasePath) {
		   let contactDB = FMDatabase(path: databasePath)
		   if contactDB.open() {
			   dump("열렸다")
			   let sql_stmt = "create table if not exists todolist (id integer primary key autoincrement, date text, title text, content text)"
			   if !contactDB.executeStatements(sql_stmt) {
				   print("Error: \(contactDB.lastErrorMessage())")
			   }
			   contactDB.close()
		   } else {
			   print("Error: \(contactDB.lastErrorMessage())")
		   }
	   } else {
		   dump("파일 있다")
	   }
   }
	
	func loadDB() {
		let contactDB = FMDatabase(path: databasePath)
		if contactDB.open() {
			let sql = "select title from todolist"
			
			do {
				
				let results: FMResultSet? = try contactDB.executeQuery(sql, values: nil)
				
				if results?.next() == true {
					dump("Record Found")
					dump(results?.string(forColumn: "title"))
				} else {
					dump("Record Not Found")
				}
				
			} catch {
				print("Error: \(contactDB.lastErrorMessage())")
			}
			
			contactDB.close()
			
		} else {
			dump("DB Open Failed")
			print("Error: \(contactDB.lastErrorMessage())")
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
		cell.titleLabel.text = myData[indexPath.row]
		dataIndex = indexPath.row
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.destination is DetailViewController {
//			let vc = segue.destination as? DetailViewController
//			vc?.titleLabel
//		}
//	}
}
