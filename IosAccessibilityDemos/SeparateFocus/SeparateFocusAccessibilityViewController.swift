//
//  SeparateFocusAccessibilityViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/06/11.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class SeparateFocusAccessibilityViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cleanLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cleanNameButton: UIButton!
    @IBOutlet weak var cleanEmailButton: UIButton!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var cleanView: UIView!
    @IBOutlet weak var confirmView: UIView!
    
    @IBAction func onConfirmButtonClicked(_ sender: UIButton) {
        self.nameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        
        let alert = UIAlertController(title: "", message: "감사합니다", preferredStyle: .alert)
        let completeAction = UIAlertAction(title: "확인", style: .default) { action in
            self.cleanTextField()
        }
        alert.addAction(completeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onCleanNameButtonClicked(_ sender: UIButton) {
        self.nameTextField.text = ""
        
    }
    
    @IBAction func onCleanEmailButtonClicked(_ sender: UIButton) {
        self.emailTextField.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreenTitle()
    }
    
    override func viewDidLayoutSubviews() {
        self.setAccessibility()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    private func setScreenTitle() {
        self.title = "접근성이 적용된 경우"
    }
    
    private func cleanTextField() {
        self.nameTextField.text = ""
        self.emailTextField.text = ""
    }
    
    private func setAccessibility() {
        // Element로 접근성을 적용시키는 방식
        self.setViewElementAccessibility()
        
        // 컨테이터 뷰구조로 접근성을 적용시키는 방식
        self.disableAccessibility(superView: self.emailView)
        self.setContainerViewAccessibility(containerView: self.emailView, traitsView: self.emailTextField, label: self.emailLabel.text ?? "이메일주소")
        
        
        self.disableAccessibility(superView: self.confirmView)
        self.setContainerViewAccessibility(containerView: self.confirmView, traitsView: self.confirmButton, label: self.confirmLabel.text ?? "확인")
        
        self.cleanLabel.isAccessibilityElement = false
        self.setContainerViewAccessibility(containerView: self.cleanView, traitsView: self.confirmButton, label: self.cleanLabel.text ?? "삭제")
        

    }
    
    // superView의 자식view isAccessibilityElement를 false로 만들어주는 함수
    private func disableAccessibility(superView: UIView) {
        
        for _view in superView.subviews {
            _view.isAccessibilityElement = false
        }
        
    }
    
    // MARK: Element로 접근성을 적용시키는 함수
    private func setViewElementAccessibility() {
        
        // Element를 사용하는 UIView는 isAccessibilityElement = false
        self.disableAccessibility(superView: self.nameView)
        
        // name Element 생성
        let nameElement = self.getElement(view: self.nameTextField, labelView: self.nameLabel, label: self.nameLabel.text)
       
        // nameView에 element 설정
        self.nameView.accessibilityElements = [nameElement]
    }
    
    // UIView와 UILabel의 element를 생성해주는 함수
    private func getElement(view: UIView, labelView: UILabel, label: String?) -> UIAccessibilityElement {
        let element = UIAccessibilityElement(accessibilityContainer: self)
        element.accessibilityFrameInContainerSpace = view.frame.union(labelView.frame)
        element.accessibilityLabel = label ?? labelView.text
        element.accessibilityTraits = view.accessibilityTraits
        return element
    }
    
    // MARK: 컨테이터 뷰구조로 접근성을 적용시키는 함수
    private func setContainerViewAccessibility(containerView: UIView, traitsView: UIView, label: String) {
        
        containerView.isAccessibilityElement = true
        containerView.accessibilityLabel = label
        containerView.accessibilityTraits = traitsView.accessibilityTraits
    }
}
