//
//  TableCell.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 21/09/2020.
//  Copyright © 2020 Jeonggyu Park. All rights reserved.
//

import Foundation
import UIKit

class FruitTableCell: UITableViewCell {
    var fruitName: String?
    
    var fruitView : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(fruitView)
        
        //여기에 constraint를 잘못 지정하면 cell이 하나만 표시되는 등 이상하게 표시되니 주의
        //nameView.centerYAnchor.constraint(equalTo: self.centerYAnchor) 이것이 원인이었을 듯
        
        
        fruitView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        
        fruitView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        fruitView.rightAnchor.constraint(equalTo: self.rightAnchor,constant:0 ).isActive = true
        fruitView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:0 ).isActive = true
        fruitView.textAlignment = .center
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let fruitName = fruitName {
            fruitView.text = fruitName
        }
    }
}
