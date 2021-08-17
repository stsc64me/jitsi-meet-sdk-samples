//
//  MenuDropDownCell.swift
//  App
//
//  Created by Sittisak Teanpanom on 11/8/2564 BE.
//  Copyright © 2564 BE Atlassian Inc. All rights reserved.
//

import UIKit
import DropDown
class MenuDropDownCell: DropDownCell {

    @IBOutlet var imageDropdown: UIImageView!
    
    @IBOutlet var titleDropdown: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
