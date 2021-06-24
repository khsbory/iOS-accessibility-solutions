//
//  NewDragNDropMainViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/06/22.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class NewDragNDropMainViewController: UIViewController {
    
     override func viewDidLoad() {
         super.viewDidLoad()
         setScreenTitle()
           
     }
     
     private func setScreenTitle() {
         self.title = "밀기 동작에 대한 접근성 데모"
     }
     
     @IBAction func launchSeparateFocusWithoutAccessibility(_ sender: Any) {
         Constants.isAccessibilityApplied = false
         showScreenOnOtherStoryboard(storyboardName: "NewDragNDrop", viewControllerStoryboardId: "NewDragNDrop")
         
     }
     
     @IBAction func launchSeparateFocusWithAccessibility(_ sender: Any) {
         Constants.isAccessibilityApplied = true
         showScreenOnOtherStoryboard(storyboardName: "NewDragNDrop", viewControllerStoryboardId: "NewDragNDrop")
         
     }
     
     private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
         let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
         //self.present(viewController, animated: true, completion: nil)
         self.navigationController?.pushViewController(viewController, animated: true)
     }
     
    

}
