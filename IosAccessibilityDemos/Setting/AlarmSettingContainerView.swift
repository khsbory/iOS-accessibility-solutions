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
   

   // MARK: Accessibility Logic

    /*
        VoiceOver relies on `accessibilityElements` returning an array of consistent objects that persist
        as the user swipes through an app. We therefore have to cache our array of computed `accessibilityElements`
        so that we don't get into an infinite loop of swiping. We reset this cached array whenever a new dog object is set
        so that `accessibilityElements` can be recomputed.
    */
    /// - Tag: grouping_elements
    private var _accessibilityElements: [Any]?

    override var accessibilityElements: [Any]? {
        set {
            _accessibilityElements = newValue
        }

        get {
            // Return the accessibility elements if we've already created them.
            if let _accessibilityElements = _accessibilityElements {
                return _accessibilityElements
            }

            /*
                We want to create a custom accessibility element that represents a grouping of each
                title and content label pair so that the VoiceOver user can interact with them as a unified element.
                This is important because it reduces the amount of times the user has to swipe through the display
                to find the information they're looking for, and because without grouping the labels,
                the content labels lose the context of what they represent.
            */
            if (Constants.isAccessibilityApplied) {
           
            var elements = [UIAccessibilityElement]()
            let hamburgerStoreLabelElement = UIAccessibilityElement(accessibilityContainer: self)
                hamburgerStoreLabelElement.accessibilityLabel = "\(hamburgerStoreLabel.text!)"
                
                /*
                This tells VoiceOver where the object should be onscreen. As the user
                touches around with their finger, we can determine if an element is below
                their finger.
            */
                hamburgerStoreLabelElement.accessibilityFrameInContainerSpace = hamburgerStoreLabel.frame
            elements.append(hamburgerStoreLabelElement)
                
                let newMenuNoticeSwitchElement = UIAccessibilityElement(accessibilityContainer: self)
                    newMenuNoticeSwitchElement.accessibilityLabel = "새로운 메뉴 출시 알림"
                    newMenuNoticeSwitchElement.accessibilityFrameInContainerSpace = newMenuNoticeSwitch.frame
                elements.append(newMenuNoticeSwitchElement)
                
            let newMenuNoticeLabelElement = UIAccessibilityElement(accessibilityContainer: self)
                newMenuNoticeLabelElement.accessibilityLabel = NSLocalizedString("새로운 메뉴가 나오면 알려드립니다.", bundle: .main, comment: "")
                newMenuNoticeLabelElement.accessibilityFrameInContainerSpace = newMenuNoticeLabel.frame
            elements.append(newMenuNoticeLabelElement)
            
            
       
            
            _accessibilityElements = elements
            }
            return _accessibilityElements
        }
    }
}


