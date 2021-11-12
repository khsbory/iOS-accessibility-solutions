//
//  CalendarMainViewController.swift
//  IosAccessibilityDemos
//
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class CalendarMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setScreenTitle() {
        self.title = "캘린더 데모"
    }
    
    @IBAction func launchSeparateFocusWithoutAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = false
        showScreenOnOtherStoryboard(storyboardName: "CalendarDemo", viewControllerStoryboardId: "CalendarDemo")
        
    }
    
    @IBAction func launchSeparateFocusWithAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = true
        showScreenOnOtherStoryboard(storyboardName: "CalendarDemo", viewControllerStoryboardId: "AccesibilityCalendarDemo")
        
    }
    
    private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
