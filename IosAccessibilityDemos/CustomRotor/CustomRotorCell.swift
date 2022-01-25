//
//  CustomRotorCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2022/01/18.
//  Copyright © 2022 Jeonggyu Park. All rights reserved.
//

import UIKit

class CustomRotorCell: UITableViewCell {

    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
