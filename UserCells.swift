//
//  UserCells.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit

class UserCells: UITableViewCell {

    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var photoUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
