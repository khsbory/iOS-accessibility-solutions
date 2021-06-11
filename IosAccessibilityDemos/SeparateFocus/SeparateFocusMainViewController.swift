//
//  SeparateFocusMainViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/06/09.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class SeparateFocusMainViewController: UIViewController {
    
     override func viewDidLoad() {
         super.viewDidLoad()
         setScreenTitle()
           
     }
     
     private func setScreenTitle() {
         self.title = "분리된 접근성 초점 개선하기"
     }
     
     @IBAction func launchSeparateFocusWithoutAccessibility(_ sender: Any) {
         Constants.isAccessibilityApplied = false
         showScreenOnOtherStoryboard(storyboardName: "SeparateFocus", viewControllerStoryboardId: "SeparateFocus")
         
     }
     
     @IBAction func launchSeparateFocusWithAccessibility(_ sender: Any) {
         Constants.isAccessibilityApplied = true
         showScreenOnOtherStoryboard(storyboardName: "SeparateFocus", viewControllerStoryboardId: "SeparateFocusAccessibility")
         
     }
     
     private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
         let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
         //self.present(viewController, animated: true, completion: nil)
         self.navigationController?.pushViewController(viewController, animated: true)
     }
     
    

}
