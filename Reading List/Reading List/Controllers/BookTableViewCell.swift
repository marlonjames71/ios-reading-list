//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Marlon Raskin on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

	
	
	@IBOutlet var bookLabel: UILabel!
	@IBOutlet var checkboxButton: UIButton!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	@IBAction func checkboxButtonTapped(_ sender: UIButton) {
	}
	

}
