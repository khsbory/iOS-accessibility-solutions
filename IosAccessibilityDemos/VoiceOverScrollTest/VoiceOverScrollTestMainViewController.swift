//
//  VoiceOverScrollTestMainViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/08/04.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class VoiceOverScrollTestMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setScreenTitle() {
        self.title = "보이스오버 스크롤 테스트"
    }
    
    @IBAction func launchSeparateFocusWithoutAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = false
        showScreenOnOtherStoryboard(storyboardName: "VoiceOverScrollTest", viewControllerStoryboardId: "VoiceOverScrollTest")
        
    }
    
    @IBAction func launchSeparateFocusWithAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = true
        showScreenOnOtherStoryboard(storyboardName: "VoiceOverScrollTest", viewControllerStoryboardId: "VoiceOverScrollTest")
        
    }
    
    private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

}
