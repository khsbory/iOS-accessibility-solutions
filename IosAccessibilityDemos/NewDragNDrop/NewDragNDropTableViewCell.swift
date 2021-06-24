//
//  NweDragNDropTableViewCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/06/22.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class NewDragNDropTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .lightGray : .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
