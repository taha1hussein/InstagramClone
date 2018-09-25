//
//  HomeCell.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/15/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
     var items = [PostData]()
    
    @IBOutlet weak var unlike: UIButton!
    @IBOutlet weak var Like: UIButton!
    
    @IBOutlet weak var unlikesLabel: UILabel!
    @IBOutlet weak var LikeLabel: UILabel!
    @IBOutlet weak var HomeUserImage: UIImageView!
    @IBOutlet weak var HomeUserName: UILabel!
    @IBOutlet weak var HomeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
    
}
