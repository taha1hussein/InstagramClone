//
//  cell.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 9/12/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit

class cell: UITableViewCell {
    
    @IBOutlet weak var ActivityMessage: UILabel!
    @IBOutlet weak var ActivityNameUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
