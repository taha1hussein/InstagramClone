//
//  TableViewCell.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/31/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Images: UIImageView!
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
