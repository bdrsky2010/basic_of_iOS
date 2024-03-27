//
//  AttractionTableViewController.swift
//  TableViewDemo
//
//  Created by Minjae Kim on 11/16/23.
//

import UIKit

class AttractionTableViewController: UITableViewController {

	// 테이블 목록
	var items = ["Kim", "Park", "Hwang"]
	
	@IBOutlet var tvListView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	override func viewWillAppear(_ animated: Bool) {
		tvListView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return items.count
    }

	// items값을 셀에 추가
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// 'AttractionTabelCell' 부분은 스토리보드 화면에서 테이블 뷰 셀 'Table View Cell'의 Identifier에 넣은 이름을 넣어줌
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttractionTabelCell", for: indexPath)

		cell.textLabel?.text = items[indexPath.row]
		cell.imageView?.image = UIImage(systemName: "square.and.arrow.up")
		
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
	
	// Delete를 한글로 변경
	override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "삭제"
	}

	// 목록 순서 바뀌
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		// 이동할 아이템 위치를 기록
		
		// 이동할 아이템을 삭제해줌과 동시에 이동할 아이템 위치를 기록
		let itemRow = items.remove(at: fromIndexPath.row)
		
		// 삭제된 아이템을 이동할 위치로 삽입
		items.insert(itemRow, at: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
