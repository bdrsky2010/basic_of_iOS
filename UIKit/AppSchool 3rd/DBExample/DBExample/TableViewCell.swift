//
//  TableViewCell.swift
//  DBExample
//
//  Created by Minjae Kim on 11/23/23.
//

import UIKit

class TableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
		dump("awakeFromNib")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
