//
//  HLALViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2022/02/13.
//  Copyright © 2022 Jeonggyu Park. All rights reserved.
//

import UIKit

class HLALViewController: UIViewController {

    @IBOutlet weak var lblHeadingLevelTest: UILabel!
    
    @IBOutlet weak var lblFruit: UILabel!
    
    @IBOutlet weak var lblAccessibilityLanguageTest: UILabel!
    
    @IBOutlet weak var btnAccessibilityLanguageTest: UILabel!
    @IBOutlet weak var containerAccessiblityLanguageTest: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Constants.isAccessibilityApplied {
            self.initAccessibilityLabelSetting()
            self.initAccessibilityButtonSetting()
        }
    }
    
    func initAccessibilityLabelSetting() {
        guard let headingLevelText = self.lblHeadingLevelTest.text, let fruitText = self.lblFruit.text, let languageText = self.lblAccessibilityLanguageTest.text else {
            return
        }
        self.lblHeadingLevelTest.attributedText = NSMutableAttributedString().headingLevel(string: headingLevelText, level: 1)
        self.lblFruit.attributedText = NSMutableAttributedString().headingLevel(string: fruitText, level: 2)
        self.lblAccessibilityLanguageTest.attributedText = NSMutableAttributedString()
            .headingLevel(string: languageText, level: 1)
        
        self.lblHeadingLevelTest.accessibilityTraits = .header
        self.lblFruit.accessibilityTraits = .header
        self.lblAccessibilityLanguageTest.accessibilityTraits = .header
        
    }
    
    func initAccessibilityButtonSetting() {
        
        self.containerAccessiblityLanguageTest.accessibilityCustomActions = makeAccessibilityCustomActions()
        
    }
    
    func makeAccessibilityCustomActions() -> [UIAccessibilityCustomAction] {
        
        let deleteAction = UIAccessibilityCustomAction(name: "delete") { (action) -> Bool in
            self.selectDelete()
            return true
        }
        deleteAction.accessibilityLanguage = "en"
        return [deleteAction]
    }

    func selectDelete() {
        
    }
}


extension UILabel {
    func headingLevel(targetString: String, level: Int) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.accessibilityTextHeadingLevel, value: NSNumber(value: level), range: range)
        self.attributedText = attributedString
    }


}
extension NSMutableAttributedString {

    func headingLevel(string: String, level: Int) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.accessibilityTextHeadingLevel: NSNumber(value: level)]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    

}
