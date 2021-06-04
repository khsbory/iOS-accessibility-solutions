//
//  AlarmSettingContainerView.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/05/27.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//
import UIKit

class AlarmSettingContainerView: UIView {
    // MARK: Properties

    @IBOutlet var hamburgerStoreLabel: UILabel!
    @IBOutlet var newMenuNoticeLabel: UILabel!
    @IBOutlet var newMenuNoticeSwitch: UISwitch!
   
    override var accessibilityLabel: String? {
        get { "\(hamburgerStoreLabel.text ?? ""). \("새로운 메뉴가 나오면 알려드립니다.")" }
        set {}
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        get { newMenuNoticeSwitch.accessibilityTraits }
        set {}
    }

    override var accessibilityValue: String? {
        get { newMenuNoticeSwitch.accessibilityValue }
        set {}
    }

    override func accessibilityActivate() -> Bool {
        newMenuNoticeSwitch.isOn.toggle()
        return true
    }
    
    
   
}


