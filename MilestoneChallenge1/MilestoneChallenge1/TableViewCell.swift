//
//  TableViewCell.swift
//  MilestoneChallenge1
//
//  Created by 원현식 on 2020/02/07.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
