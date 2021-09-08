//
//  RollingBanner2ViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/09/02.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class RollingBanner2ViewController: UIViewController {
        
    @IBOutlet weak var bannerView: BannerView!
    
    let numberArray: Array<String> = ["1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initBannerView()
        self.setScreenTitle()
                
    }
    
    private func setScreenTitle() {
        
        if Constants.isAccessibilityApplied {
            self.title = "접근성이 적용된 경우"
        } else {
            self.title = "접근성이 적용되지 않은 경우"
        }
    }
    
    func initBannerView() {
        bannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBannerClicked)))
        bannerView.numberArray = self.numberArray
        bannerView.initBannerView()
    }
    
    @objc func onBannerClicked() {
        
        let number = numberArray[bannerView.nowPage]
        let alert = UIAlertController(title: "", message: "\(number) 클릭함", preferredStyle: .alert)
        let completeAction = UIAlertAction(title: "확인", style: .default) { action in
        }
        alert.addAction(completeAction)
        self.present(alert, animated: true, completion: nil)
    }
}


class BannerView: UIScrollView {
    
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    var numberArray: Array<String> = []
    var timer: Timer?
    var nowPage: Int = 0
    
    override func accessibilityElementDidBecomeFocused() {
        if Constants.isAccessibilityApplied {
            self.stopTimer()
        }
    }
    
    override func accessibilityElementDidLoseFocus() {
        if Constants.isAccessibilityApplied {
            self.startTimer()
        }
    }
    
    override func awakeFromNib() {
    }
    
    
    func initBannerView() {
        
        self.delegate = self
        
        self.initLabel()
        self.startTimer()
        
        if Constants.isAccessibilityApplied {
            self.initAccessibility()
        }
    }
    
    func initLabel() {
        
        var txt: String = ""
        for (i,number) in numberArray.enumerated() {
            txt += "\(number)"
            if i != numberArray.count - 1 {
                txt += "\n"
            }
        }
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = 50
        style.minimumLineHeight = 50
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (50 - numberLabel.font.lineHeight) / 4
        ]
        style.alignment = .center
        
        let attrString = NSAttributedString(string: txt, attributes: attributes)
        numberLabel.attributedText = attrString
    }
    
    
    
    func initAccessibility() {
        numberLabel.isAccessibilityElement = false
        self.isAccessibilityElement = true
        
        self.accessibilityLabel = numberArray[0]
    }
    
    
    // 2초마다 실행되는 타이머
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    // 배너 움직이는 매서드
    func bannerMove() {
        
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == numberArray.count - 1 {
            // 맨 처음 페이지로 돌아감
            self.setContentOffset(.zero, animated: false)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        
        let point = CGPoint(x: 0, y: 50 * nowPage)
        self.setContentOffset(point, animated: true)
        
        if Constants.isAccessibilityApplied {
            self.accessibilityLabel = numberArray[nowPage]
        }
        
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

extension BannerView : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.y) / Int(scrollView.frame.height)
    }
}
