//
//  MusicPlayerMainViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/02/03.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class MusicPlayerMainViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
          
    }
    
    private func setScreenTitle() {
        //아래 코드를 사용하면 Back 대신 title이 표시됨
        //navigationController?.navigationBar.topItem?.title = "필터데모"
        self.title = "뮤직플레이어"
    }
    
    @IBAction func launchDemoWithoutAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = false
        showScreenOnOtherStoryboard(storyboardName: "MusicPlayer", viewControllerStoryboardId: "music_player")
        
    }
    
    @IBAction func launchDemoWithAccessibility(_ sender: Any) {
        Constants.isAccessibilityApplied = true
        showScreenOnOtherStoryboard(storyboardName: "MusicPlayer", viewControllerStoryboardId: "music_player")
        
    }
    
    private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

