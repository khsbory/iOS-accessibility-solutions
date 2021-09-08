//
//  VoiceOverScrollTestTableViewCell.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/08/04.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class VoiceOverScrollTestTableViewCell: UITableViewCell {

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
