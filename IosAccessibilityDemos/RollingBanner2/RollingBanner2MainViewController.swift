//
//  RollingBanner2MainViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/09/02.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class RollingBanner2MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setScreenTitle() {
        self.title = "롤링배너 2탄"
    }
    
    @IBAction func launchSeparateFocusWithoutAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = false
        showScreenOnOtherStoryboard(storyboardName: "RollingBanner2", viewControllerStoryboardId: "RollingBanner2")
        
    }
    
    @IBAction func launchSeparateFocusWithAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = true
        showScreenOnOtherStoryboard(storyboardName: "RollingBanner2", viewControllerStoryboardId: "RollingBanner2")
        
    }
    
    private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

}
