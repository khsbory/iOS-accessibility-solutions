//
//  NweDragNDropTableViewCell.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/06/22.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class NewDragNDropTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var number: Int = 0 
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .lightGray : .white
        }
    }
    
    @IBAction func onFavoriteButtonClicked(_ sender: Any) {
        self.setFavorite()
    }
    
    var delegate: NewDragNDropDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 접근성을 적용하는 함수
    func setAccessibility() {
        
        if self.favoriteButton.isEnabled {
            // 관심 버튼에 접근성 버튼 해제
            self.favoriteButton.isAccessibilityElement = false
            self.accessibilityCustomActions = self.makeAccessibilityCustomActions()
        } else {
            self.accessibilityCustomActions = []
        }
        
    }
    
    // 관심 선택/해제
    func setFavorite() {
        self.favoriteButton.isSelected = !self.favoriteButton.isSelected
        
        if self.favoriteButton.isSelected {
            delegate?.selectFavorite(number: number)
        } else {
            delegate?.deselectFavorite(number: number)
        }
    }
    
    // CustomAction을 생성하는 함수
    func makeAccessibilityCustomActions() -> [UIAccessibilityCustomAction] {
        var actionName: String = "관심 선택"
        
        if self.favoriteButton.isSelected {
            actionName = "관심 해제"
        } else {
            actionName = "관심 선택"
        }
        
        let action = UIAccessibilityCustomAction(name: actionName) { (action) -> Bool in
            UIAccessibility.post(notification: .announcement, argument: "\(actionName)됨")
            self.setFavorite()
            self.accessibilityCustomActions = self.makeAccessibilityCustomActions()
            return true
        }
        return [action]
    }
}
