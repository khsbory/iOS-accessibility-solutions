//
//  TableViewMoveRowDemoCell.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/10/01.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class TableViewMoveRowDemoCell: UITableViewCell {
    
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
