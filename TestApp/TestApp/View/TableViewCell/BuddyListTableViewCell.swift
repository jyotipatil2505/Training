//
//  BuddyListTableViewCell.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 14/11/20.
//

import UIKit

class BuddyListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
