//
//  BannerViewController.swift
//  IosAccessibilityDemos
//
//  Created by Hyongsop Kim on 2021/02/15.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit
class BannerViewController: UIViewController {
    var mode  :VoiceOverMode = .none
    @IBOutlet weak var scrollView: MYScrollView!
    @IBOutlet weak var btPrev: UIButton!
    @IBOutlet weak var btNext: UIButton!

    
    var count : Int = 0
    
    let banners = [
        "맥도날드",
        "롯데리아",
        "맘스터치",
        "버거킹",
        "파파이스"
    ]
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func next(_ sender: UIButton) {
        self.count = self.count + 1
        
        if self.count > self.banners.count - 1  {
            self.count = 0
        }
  
        let x = UIScreen.main.bounds.width * CGFloat(self.count)
        
        self.scrollView.contentOffset = CGPoint(x: x, y: 0)
        

       
        sleep(1)
        //UIAccessibility.post(notification: .screenChanged, argument: scrollView)
        //annoucement 제외 요구
        UIAccessibility.post(notification: .announcement, argument: self.banners[self.count])
        
        //sleep(1)

    }
    @IBAction func prev(_ sender: UIButton) {
        self.count = self.count - 1
        
        if self.count < 0  {
            self.count = self.banners.count - 1
        }

        let x = UIScreen.main.bounds.width * CGFloat(self.count)
        
        self.scrollView.contentOffset = CGPoint(x: x, y: 0)
        
        sleep(1)
        UIAccessibility.post(notification: .announcement, argument: banners[self.count])
    }
    
    func setup() {
        

        print(self.mode)
        
        if self.mode == .running {
        
            if UIAccessibility.isVoiceOverRunning {
                self.mode = .running
            }else {
               self.mode = .none
            }
        }
        
        
        let frame = scrollView.frame
        
        
        var x:CGFloat = 0
        let y:CGFloat = 0
        for (i,banner) in banners.enumerated() {
            
            let width = self.scrollView.frame.width
            let button = MyButton(frame: CGRect(x: x, y: y, width: width, height: 252))
            button.setTitle(banner, for: .normal)
            button.tag = i
//            view.addSubview(label)
            
            button.backgroundColor = .red
            
            button.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
            view.addSubview(button)
            
            
            scrollView.addSubview(button)
            
            x = x + width
            
        }
        
        


        
        scrollView.contentSize = CGSize(width: x, height: frame.size.height)
        
        
        //let w = frame.size.width
        
        switch(mode) {
        case .none:
            //타이머실행
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer) in
                self.count = self.count + 1
                
                if self.count > self.banners.count - 1  {
                    self.count = 0
                }
                
                let x = frame.size.width * CGFloat(self.count)
          
                self.scrollView.contentOffset = CGPoint(x: x, y: 0)
                
            }
            
            btPrev.isHidden = true
            btNext.isHidden = true
            
            self.title = "롤링배너"
        case .running:
             self.title = "접근성이 적용된 예시"
            //타이머 실행 안함
            btPrev.isHidden = false
            btNext.isHidden = false
            
            scrollView.myDelegate = self
            scrollView.isAccessibilityElement = true
            scrollView.accessibilityTraits = [.adjustable, .button]
            scrollView.accessibilityLabel = "배너"
            scrollView.accessibilityValue = self.banners[self.count]
        }
    }
    

    
    @objc func clicked(_ sender:UIButton) {
        
        let tag = sender.tag
        
        let title = banners[tag]
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    ()
              case .cancel:
                    ()
              case .destructive:
                    ()
        }}))
        self.present(alert, animated: true, completion: nil)
    }

}

extension BannerViewController : MyScrollViewDelegate{
    func scrollPrev() {
        self.prev(self.btPrev)
        scrollView.accessibilityValue = self.banners[self.count]
    }
    func scrollNext() {
        self.next(self.btNext)
        scrollView.accessibilityValue = self.banners[self.count]
    }
}



class MyButton : UIButton {
    
}

protocol MyScrollViewDelegate {
    func scrollNext()
    func scrollPrev()
}

class MYScrollView : UIScrollView {
    
    var myDelegate: MyScrollViewDelegate?
    
    override func accessibilityIncrement() {
       // scrollView.accessibilityValue = self.banners[self.count]
        
        //print("increment")
        
        myDelegate?.scrollNext()
        
    }
    

    override func accessibilityDecrement() {
        //print("decrement")
        
        myDelegate?.scrollPrev()
        
    }
}

