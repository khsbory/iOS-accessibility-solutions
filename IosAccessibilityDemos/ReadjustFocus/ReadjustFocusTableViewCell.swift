//
//  ReadjustFocusTableViewCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/07/27.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReadjustFocusTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
