//
//  MainPageViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/01/18.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class VerticalScrollDemo2ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var pageContainer: UIView!
    
    @IBOutlet weak var backButton: UIImageView!
 
    var pageVC: UIPageViewController!
    var currentIdx:Int = 0
    var selectedIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewPager()
        initBackButton()
        setScreenTitle()
    }
    
    private func setScreenTitle() {
        self.title = Constants.isAccessibilityApplied ? "접근성이 적용된 경우" : "접근성이 적용되지 않은 경우"
    }
    
    
    private func initBackButton() {
        backButton.accessibilityTraits = .button
        backButton.isAccessibilityElement = true
        backButton.accessibilityLabel = "뒤로가기"
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBakButtonClicked)))
     }
    
    private func initViewPager() {
        self.pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageVC.dataSource = self
        self.pageVC.delegate = self
        
        //UIPageViewController는 하단에 자동으로 page indicator가 생김. 배경이 흰색이면 indicator가 안보일 수 있음
        let startVC = UIStoryboard(name: "FirstPage", bundle: nil).instantiateViewController(withIdentifier: "firstPage") as? FirstPageViewController
        
        
        let viewControllers = [startVC]
        print("plusapps viewControllers count", viewControllers.count)
      
        self.pageVC.setViewControllers(viewControllers as? [UIViewController] , direction: .forward, animated: true, completion: nil)
        self.addChild(self.pageVC)
        self.pageContainer.addSubview(self.pageVC.view)
        
        // AutoLayout
        self.pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.pageContainer.addConstraint(NSLayoutConstraint(item: self.pageVC.view, attribute: .top, relatedBy: .equal, toItem: self.pageContainer, attribute: .top, multiplier: 1, constant: 0))
        self.pageContainer.addConstraint(NSLayoutConstraint(item: self.pageVC.view, attribute: .left, relatedBy: .equal, toItem: self.pageContainer, attribute: .left, multiplier: 1, constant: 0))
        self.pageContainer.addConstraint(NSLayoutConstraint(item: self.pageVC.view, attribute: .bottom, relatedBy: .equal, toItem: self.pageContainer, attribute: .bottom, multiplier: 1, constant: 0))
        self.pageContainer.addConstraint(NSLayoutConstraint(item: self.pageVC.view, attribute: .right, relatedBy: .equal, toItem: self.pageContainer, attribute: .right, multiplier: 1, constant: 0))

        refreshPageIndicator()
    }
    
    @objc func onBakButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
 
    
    // 현재 페이지 로드가 끝났을 때
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
         
            if pageVC.viewControllers![0] is FirstPageViewController {
                currentIdx = 0
            } else if pageVC.viewControllers![0] is SecondPageViewController {
                currentIdx = 1
            }
            
            refreshPageIndicator()
        }
    }
    
    // 현재 페이지 뷰의 이전 뷰를 미리 로드
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      
        if (currentIdx == 0) {
           return nil
        } else if (currentIdx == 1) {
            guard let vc = UIStoryboard(name: "FirstPage", bundle: nil).instantiateViewController(withIdentifier: "firstPage") as? FirstPageViewController else { return FirstPageViewController() }
            return vc
        }
        return nil
    }
    
    // 현재 페이지 뷰의 다음 뷰를 미리 로드
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      
        if (currentIdx == 0) {
            guard let vc = UIStoryboard(name: "SecondPage", bundle: nil).instantiateViewController(withIdentifier: "secondPage") as? SecondPageViewController else { return SecondPageViewController() }
            return vc
        } else if (currentIdx == 1) {
           return nil
        }
        return nil
    }
    
    // 인디케이터 개수
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    // 인디케이터 초기 선택 값
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    private func refreshPageIndicator() {
       
    }
}
