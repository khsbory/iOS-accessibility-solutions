//
//  NewDragNDropPopup.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/09/24.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class NewDragNDropPopup: UIViewController {
    
    // popup dim 투명도
    private final let DIM_ALPHA: CGFloat = 0.3
    
    // popup dim view
    @IBOutlet weak var vDim: UIView!
    // popup content view
    @IBOutlet weak var vPopup: UIView!
    
    var isShow: Bool = false
    
    @IBAction func onShareButtonClicked(_ sender: Any) {
        self.showAlert()
    }
    
    @IBAction func onCommentButtonClicked(_ sender: Any) {
        self.showAlert()
    }
    
    @IBAction func onSpamButtonClicked(_ sender: Any) {
        self.showAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
    }
    
}
extension NewDragNDropPopup {
    
    func showAnim(vc: UIViewController? = UIApplication.shared.keyWindow?.visibleViewController , parentAddView: UIView? = UIApplication.shared.keyWindow?.visibleViewController?.view, _ completion: @escaping ()->()) {
        
        if isShow {
            return
        }
        
        guard let currentVC = vc else {
            completion()
            return
        }
        
        var pView = parentAddView
        
        if pView == nil {
            pView = vc?.view
        }
        
        guard let parentView = pView else {
            completion()
            return
        }
        
        currentVC.addChild(self)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(self.view)
        self.view.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 0).isActive = true
        
        self.view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0).isActive = true
        
        self.view.rightAnchor.constraint(equalTo: parentView.rightAnchor,constant:0 ).isActive = true
        self.view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor,constant:0 ).isActive = true
        
        
        self.vDim.alpha = 0.0
        self.vPopup.alpha = 0.0
        self.view.layoutIfNeeded()
        
        self.isShow = true
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            if let _self = self {
                _self.vDim.alpha = _self.DIM_ALPHA
            }
        } completion: { (complete) in
            UIView.animate(withDuration: 0.25) { [weak self] in
                if let _self = self {
                    _self.vPopup.alpha = 1.0
                }
            } completion: { (complete) in
                completion()
            }
        }
    }
    
    func hideAnim(_ completion: @escaping ()->()) {
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                if let _self = self {
                    _self.vPopup.alpha = 0.0
                }
            }) { (complete) in
                UIView.animate(withDuration: 0.25, animations: { [weak self] in
                    self?.vDim.alpha = 0.0
                }) { [weak self] complete in
                    if let _self = self {
                        _self.isShow = false
                        _self.view.removeFromSuperview()
                        _self.removeFromParent()
                    }
                }
            }
        }
    }
    
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        self.hideAnim() {
            
        }
    }
    
    @IBAction func btnCompletePressed(_ sender: UIButton) {
        self.hideAnim() {
            
        }
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "", message: "준비중입니다.", preferredStyle: .alert)
        let completeAction = UIAlertAction(title: "확인", style: .default) { action in
            
        }
        alert.addAction(completeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    /**
     # visibleViewControllerFrom
     - Author: suni
     - Date: 21.04.06
     - Parameters:
        - vc: rootViewController 혹은 UITapViewController
     - Returns: UIViewController?
     - Note: vc내에서 가장 최상위에 있는 뷰컨트롤러 반환
    */
    public func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

