//
//  ReadjustFocusMainViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/07/27.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReadjustFocusMainViewController: UIViewController {
    
     override func viewDidLoad() {
         super.viewDidLoad()
         setScreenTitle()
           
     }
     
     private func setScreenTitle() {
         self.title = "접근성 초점 재조정"
     }
     
     @IBAction func launchSeparateFocusWithoutAccessibility(_ sender: Any) {
         Constants.isAccessibilityApplied = false
         showScreenOnOtherStoryboard(storyboardName: "ReadjustFocus", viewControllerStoryboardId: "ReadjustFocus")
         
     }
     
     @IBAction func launchSeparateFocusWithAccessibility(_ sender: Any) {
         Constants.isAccessibilityApplied = true
         showScreenOnOtherStoryboard(storyboardName: "ReadjustFocus", viewControllerStoryboardId: "ReadjustFocus")
         
     }
     
     private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
         let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
         //self.present(viewController, animated: true, completion: nil)
         self.navigationController?.pushViewController(viewController, animated: true)
     }
     
}
