//
//  VerticalScrollDemoViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 21/09/2020.
//  Copyright © 2020 Jeonggyu Park. All rights reserved.
//

import UIKit

class VerticalScrollDemoViewController: UIViewController, UIScrollViewDelegate, UIScrollViewAccessibilityDelegate {

     @IBOutlet var fruitScreen: UIView!
     @IBOutlet var vegitableScreen: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fruitScreenWidthConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var vegitableScreenWidthConstraint: NSLayoutConstraint!
    
    
    private var screenType: Int?
    private let FRUIT_SCREEN: Int? = 0
    private let VEGITABLE_SCREEN: Int? = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
print("viewDidLoad")
        initScreenSize()
        // Do any additional setup after loading the view.
        scrollView.delegate = self
        screenType = FRUIT_SCREEN
        sayScreenNameForAccessibility(screenName: "과일화면")
    }
    

    private func initScreenSize() {
        let screenWidth = UIScreen.main.bounds.width
        
        fruitScreenWidthConstraint.constant = screenWidth
        vegitableScreenWidthConstraint.constant = screenWidth
    }
    
    private func sayScreenNameForAccessibility(screenName: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                              
                             UIAccessibility.post(notification: .pageScrolled , argument: screenName)
                          })
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPosition = scrollView.contentOffset.x
        let screenWidth = UIScreen.main.bounds.width
       
        // 위로 스크롤링을 하는 경우
        if (xPosition == screenWidth && screenType != VEGITABLE_SCREEN) {
            screenType = VEGITABLE_SCREEN
            
            //UIAccessibility.post를 호출하면 스크롤이 이상해져서
            //DispatchQueue.main.asyncAfter 사용
           sayScreenNameForAccessibility(screenName: "채소화면")
           
          print("채소화면")
        } else if (xPosition == 0 && screenType != FRUIT_SCREEN){
             print("과일화면")
            screenType = FRUIT_SCREEN
            sayScreenNameForAccessibility(screenName: "과일화면")
          
        }
        
    }

}
