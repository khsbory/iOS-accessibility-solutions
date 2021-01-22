//
//  WebViewDemoViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2020/11/18.
//  Copyright © 2020 Jeonggyu Park. All rights reserved.
//

import UIKit

class AccessibilityFocusDemoMainViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()     
        setScreenTitle()
          
    }
    
    private func setScreenTitle() {
        //아래 코드를 사용하면 Back 대신 title이 표시됨
        //navigationController?.navigationBar.topItem?.title = "필터데모"
        self.title = "접근성 포커스 데모"
    }
    
    @IBAction func launchAccessibilityFocusDemoWithoutAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = false
        showScreenOnOtherStoryboard(storyboardName: "AccessibilityFocusDemo", viewControllerStoryboardId: "accessibilityFocusDemo")
        
    }
    
    @IBAction func launchAccessibilityFocusDemoWithAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = true
        showScreenOnOtherStoryboard(storyboardName: "AccessibilityFocusDemo", viewControllerStoryboardId: "accessibilityFocusDemo")
        
        
    }
    
    private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
