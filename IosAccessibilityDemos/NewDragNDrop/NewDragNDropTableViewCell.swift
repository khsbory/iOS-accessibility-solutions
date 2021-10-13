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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteLabel: UILabel!
    
    var number: Int = 0
    var delegate: NewDragNDropDelegate?
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .lightGray : .white
        }
    }
    
    @IBAction func onFavoriteButtonClicked(_ sender: Any) {
        self.setFavorite()
    }
    
    @IBAction func onDeleteButtonClicked(_ sender: Any) {
        self.setDelete()
    }
    
    @IBAction func onViewLongPressGestureRecognizered(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 접근성을 적용하는 함수
    func setAccessibility() {
        
        // 삭제 버튼에 접근성 버튼 해제
        self.deleteButton.isAccessibilityElement = false
        self.deleteLabel.isAccessibilityElement = false
        
        if self.favoriteButton.isEnabled {
            // 관심 버튼에 접근성 버튼 해제
            self.favoriteButton.isAccessibilityElement = false
            
            // 커스텀 액션 추가
            self.accessibilityCustomActions = self.makeAccessibilityCustomActions()
            numberLabel.accessibilityTraits = .button
        } else {
            self.accessibilityCustomActions =
            self.makeAccessibilityCustomActions2()        }
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
    
    // 삭제 버튼 클릭
    func setDelete() {
        self.delegate?.deleteItem(number: number)
    }
    
    // CustomAction을 생성하는 함수
    func makeAccessibilityCustomActions() -> [UIAccessibilityCustomAction] {
        var favoriteActionName: String = "관심 선택"
        
        if self.favoriteButton.isSelected {
            favoriteActionName = "관심 해제"
        } else {
            favoriteActionName = "관심 선택"
        }
        
        let favoriteAction = UIAccessibilityCustomAction(name: favoriteActionName) { (action) -> Bool in
            UIAccessibility.post(notification: .announcement, argument: "\(favoriteActionName)됨")
            self.setFavorite()
            self.accessibilityCustomActions = self.makeAccessibilityCustomActions()
            return true
        }
        
        let deleteAction = UIAccessibilityCustomAction(name: "삭제") { (action) -> Bool in
            UIAccessibility.post(notification: .announcement, argument: "삭제")
            self.setDelete()
            
            return true
        }
        
        let moreAction = UIAccessibilityCustomAction(name: "더보기") { (action) -> Bool in
            
            self.delegate?.showMorePopup(number: self.number)
            
            return true
        }
        return [favoriteAction, deleteAction, moreAction]
    }
    
    func makeAccessibilityCustomActions2() -> [UIAccessibilityCustomAction] {
        let deleteAction = UIAccessibilityCustomAction(name: "삭제") { (action) -> Bool in
            UIAccessibility.post(notification: .announcement, argument: "삭제")
            self.setDelete()
            
            return true
        }
        
        let moreAction = UIAccessibilityCustomAction(name: "더보기") { (action) -> Bool in
            
            self.delegate?.showMorePopup(number: self.number)
            
            return true
        }
        return [deleteAction, moreAction]
    }

}
