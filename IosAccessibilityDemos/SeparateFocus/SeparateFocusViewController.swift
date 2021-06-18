//
//  SeparateFocusViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/06/09.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class SeparateFocusViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    private func setScreenTitle() {
        self.title = "접근성이 적용되지 않은 경우"
    }
    
    private func cleanTextField() {
        self.nameTextField.text = ""
        self.emailTextField.text = ""
    }
}
