//
//  ReloadingButtonCollectionViewCell.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/10/07.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReloadingButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    var isVoiceOverRunning: Bool = false
    
    override func accessibilityElementDidBecomeFocused() {
        print("FocusFocusFocus \(UIAccessibility.isVoiceOverRunning)")
        self.isVoiceOverRunning = true
    }
    
    override func accessibilityElementDidLoseFocus() {
        print("LoseLoseLose \(UIAccessibility.isVoiceOverRunning)")
        self.isVoiceOverRunning = false
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                self.accessibilityTraits = [.notEnabled,.button]
                self.backgroundColor = .lightGray
            }
            else {
                self.accessibilityTraits = .button
                self.backgroundColor = .white
            }
        }
    }
    
    func initCell() {
        if Constants.isAccessibilityApplied {
            self.initAccessibility()
        }
    }
    
    func initAccessibility() {
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        
        if let text = numberLabel.text {
             self.accessibilityLabel = "\(text)"
        }
    }
}
