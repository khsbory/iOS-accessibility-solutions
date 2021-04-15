//
//  FirstPageViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/01/18.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//
import UIKit


class SettingViewController: UIViewController {
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var screenTitle: UILabel!
    
    @IBOutlet weak var line2: UIView!
    
    @IBOutlet weak var macdonaldLabel: UILabel!
    
    @IBOutlet weak var lotteriaLabel: UILabel!
    @IBOutlet weak var allLabel: UILabel!
    
    @IBOutlet weak var macdonaldRadio: UIImageView!
    
    @IBOutlet weak var lotteriaRadio: UIImageView!
    @IBOutlet weak var allRadio: UIImageView!
    
    private let UNSELECTED: Int = 0
    private let SELECTED: Int = 1
    
    @IBAction func onSetMenuButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "지금은 지원하지 않는 기능입니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
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
    
    @objc func onBakButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initBackButton() {
        backButton.accessibilityTraits = .button
        backButton.isAccessibilityElement = true
        backButton.accessibilityLabel = "뒤로가기"
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBakButtonClicked)))
    }
    
    override func viewDidLoad() {
        
        initBackButton()
        initHamburgerStoreRadio()
        handleAccesibility()
     
        
    }
    
    private func handleAccesibility() {
        
        //접근성이 적용되지 않은 경우 제목과 제목 사이에 있는 경계선에 접근성 초점을 줌
        if (Constants.isAccessibilityApplied != true) {
            line2.isAccessibilityElement = true
        } else {
            screenTitle.accessibilityTraits = .header
            
            
            
        }
    }
    
    
    /*
     햄버거 매장 radio 버튼 초기화
     */
    
    private func initHamburgerStoreRadio() {
        
        lotteriaLabel.accessibilityTraits = .button
        lotteriaLabel.isUserInteractionEnabled = true
        lotteriaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLotteriaRadioClicked)))
        lotteriaRadio.isUserInteractionEnabled = true
        lotteriaRadio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLotteriaRadioClicked)))
        
        macdonaldLabel.accessibilityTraits = .button
        macdonaldLabel.isUserInteractionEnabled = true
        macdonaldLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMacdonaldRadioClicked)))
        macdonaldRadio.isUserInteractionEnabled = true
        macdonaldRadio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMacdonaldRadioClicked)))
        
        allLabel.accessibilityTraits = .button
        allLabel.isUserInteractionEnabled = true
        allLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAllRadioClicked)))
        allRadio.isUserInteractionEnabled = true
        allRadio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAllRadioClicked)))
        
    }
    
    @objc func onLotteriaRadioClicked(){
        
        if (lotteriaRadio.tag == UNSELECTED) {
            
            lotteriaRadio.image = UIImage(named: "radio_check")
            lotteriaRadio.tag = SELECTED
            
            macdonaldRadio.image = UIImage(named: "radio_uncheck")
            macdonaldRadio.tag = UNSELECTED
            
            allRadio.image = UIImage(named: "radio_uncheck")
            allRadio.tag = UNSELECTED
            
            if (Constants.isAccessibilityApplied) {
                lotteriaLabel.accessibilityTraits.insert(.selected)
                lotteriaLabel.accessibilityTraits.insert(.notEnabled)
                macdonaldLabel.accessibilityTraits.remove(.selected)
                macdonaldLabel.accessibilityTraits.remove(.notEnabled)
                allLabel.accessibilityTraits.remove(.selected)
                allLabel.accessibilityTraits.remove(.notEnabled)
            }
        }
        
    }
    
    @objc func onMacdonaldRadioClicked(){
        
        if (macdonaldRadio.tag == UNSELECTED) {
            
            macdonaldRadio.image = UIImage(named: "radio_check")
            macdonaldRadio.tag = SELECTED
            
            lotteriaRadio.image = UIImage(named: "radio_uncheck")
            lotteriaRadio.tag = UNSELECTED
            
            allRadio.image = UIImage(named: "radio_uncheck")
            allRadio.tag = UNSELECTED
            
            if (Constants.isAccessibilityApplied) {
                macdonaldLabel.accessibilityTraits.insert(.selected)
                macdonaldLabel.accessibilityTraits.insert(.notEnabled)
            
                lotteriaLabel.accessibilityTraits.remove(.selected)
                lotteriaLabel.accessibilityTraits.remove(.notEnabled)
                allLabel.accessibilityTraits.remove(.selected)
                allLabel.accessibilityTraits.remove(.notEnabled)
            }
            
        }
        
    }
    
    
    @objc func onAllRadioClicked(){
        
        if (allRadio.tag == UNSELECTED) {
            
            allRadio.image = UIImage(named: "radio_check")
            allRadio.tag = SELECTED
            
            
            lotteriaRadio.image = UIImage(named: "radio_uncheck")
            lotteriaRadio.tag = UNSELECTED
            
            macdonaldRadio.image = UIImage(named: "radio_uncheck")
            macdonaldRadio.tag = UNSELECTED
            
            if (Constants.isAccessibilityApplied) {
                allLabel.accessibilityTraits.insert(.selected)
                allLabel.accessibilityTraits.insert(.notEnabled)
                lotteriaLabel.accessibilityTraits.remove(.selected)
                lotteriaLabel.accessibilityTraits.remove(.notEnabled)
                macdonaldLabel.accessibilityTraits.remove(.selected)
                macdonaldLabel.accessibilityTraits.remove(.notEnabled)
            }
            
        }
        
    }
    
    
    
    
   
    override func accessibilityPerformEscape() -> Bool {
        self.dismiss(animated: true, completion: nil)
        return true
    }
    
    
}
