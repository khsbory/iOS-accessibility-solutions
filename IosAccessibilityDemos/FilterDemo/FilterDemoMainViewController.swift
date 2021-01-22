//
//  VerticalScrollDemo2MainViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/01/18.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class FilterDemoMainViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIImageView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackButton()
        setScreenTitle()
          
    }
    
    private func setScreenTitle() {
        //아래 코드를 사용하면 Back 대신 title이 표시됨 
        //navigationController?.navigationBar.topItem?.title = "필터데모"
        self.title = "필터데모"
    }
   
    @IBAction func launchViewControllerWithoutAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = false
         showScreenOnOtherStoryboard(storyboardName: "FilterDemo", viewControllerStoryboardId: "filterDemo")
        
    }
    
    @IBAction func launchViewControllerWithAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = true
        showScreenOnOtherStoryboard(storyboardName: "FilterDemo", viewControllerStoryboardId: "filterDemo")
        
    }
    
    private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        viewController.modalPresentationStyle = .fullScreen
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    private func initBackButton() {
        backButton.accessibilityTraits = .button
        backButton.isAccessibilityElement = true
        backButton.accessibilityLabel = "뒤로가기"
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBakButtonClicked)))
     }
    
    
    @objc func onBakButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }

    
}

