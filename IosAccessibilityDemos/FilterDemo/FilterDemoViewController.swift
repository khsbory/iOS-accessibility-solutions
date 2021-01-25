//
//  FirstPageViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/01/18.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//
import UIKit


class FilterDemoViewController: UIViewController {
    
    
    @IBOutlet weak var number1HeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var number2HeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var number3HeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var alphabet1HeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var alphabet2HeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var alphabet3HeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var number1Label: UILabel!
    
    @IBOutlet weak var number2Label: UILabel!
    
    @IBOutlet weak var number3Label: UILabel!
    @IBOutlet weak var number1Check: UIImageView!
    
    @IBOutlet weak var number2Check: UIImageView!
    
    
    @IBOutlet weak var number3Check: UIImageView!
    
    @IBOutlet weak var alphabet1Radio: UIImageView!
    
    @IBOutlet weak var alphabet2Radio: UIImageView!
    
    
    @IBOutlet weak var alphabet3Radio: UIImageView!
    
    
    @IBOutlet weak var numberSection: UIView!
    
    @IBOutlet weak var alphabetSection: UIView!
    
    
    @IBOutlet weak var alphabet1Label: UILabel!
    
    @IBOutlet weak var alphabet2Label: UILabel!
    
    @IBOutlet weak var alphabet3Label: UILabel!
    
    
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var filterResult: UILabel!
    
    
    
    @IBOutlet weak var closeSideMenuButton: UIButton!
    
    @IBOutlet weak var mainScreen: UIView!
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var backButton: UIImageView!
    
    private let UNSELECTED: Int = 0
    private let SELECTED: Int = 1
    
    @IBAction func onFilterButtonClicked(_ sender: Any) {
        sideMenu.isHidden = false
        
        if (Constants.isAccessibilityApplied) {
            mainScreen.accessibilityElementsHidden = true
            topBar.accessibilityElementsHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                UIAccessibility.post(notification: .announcement , argument: "필터 열림")
                //필터를 열었을 때 숫자 섹션에 접근성 포커스를 맞춤
                UIAccessibility.post(notification: .screenChanged, argument: self.closeSideMenuButton)
            })
            
            
            
        }
        
        
    }
    override func viewDidLoad() {
        initAlphabetSection()
        initNumberSection()
        initBackButton()
        initNumberCheck()
        initAlphabetRadio()
        initFilterResult()
        setScreenTitle()
    }
    
    private func setScreenTitle() {
      
        self.title = Constants.isAccessibilityApplied ? "접근성이 적용된 경우" : "접근성이 적용되지 않은 경우"
    }
    
    private func initFilterResult() {
        filterResult.isAccessibilityElement = false
    }
    
    
    @IBAction func closeSideMenu(_ sender: Any) {
        sideMenu.isHidden = true
        
        let selectedFilterCount = number1Check.tag + number2Check.tag + number3Check.tag + alphabet1Radio.tag + alphabet2Radio.tag + alphabet3Radio.tag
        filterResult.text = String(selectedFilterCount)
        filterButton.accessibilityLabel = "필터 선택된 필터 " + String(selectedFilterCount) + "개"
        
        applyFilter()
        
        
        if (Constants.isAccessibilityApplied) {
            mainScreen.accessibilityElementsHidden = false
            topBar.accessibilityElementsHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                UIAccessibility.post(notification: .announcement , argument: "필터 닫힘")
                UIAccessibility.post(notification: .screenChanged, argument: self.filterButton)
            })
            
            
            
        }
    }
    
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var number4: UILabel!
    @IBOutlet weak var number5: UILabel!
    @IBOutlet weak var number6: UILabel!
    @IBOutlet weak var number7: UILabel!
    @IBOutlet weak var number8: UILabel!
    @IBOutlet weak var number9: UILabel!
    @IBOutlet weak var number10: UILabel!
    @IBOutlet weak var number11: UILabel!
    @IBOutlet weak var number12: UILabel!
    @IBOutlet weak var number13: UILabel!
    @IBOutlet weak var number14: UILabel!
    @IBOutlet weak var number15: UILabel!
    @IBOutlet weak var number16: UILabel!
    @IBOutlet weak var number17: UILabel!
    @IBOutlet weak var number18: UILabel!
    @IBOutlet weak var number19: UILabel!
    @IBOutlet weak var number20: UILabel!
    @IBOutlet weak var number21: UILabel!
    @IBOutlet weak var number22: UILabel!
    @IBOutlet weak var number23: UILabel!
    @IBOutlet weak var number24: UILabel!
    @IBOutlet weak var number25: UILabel!
    @IBOutlet weak var number26: UILabel!
    @IBOutlet weak var number27: UILabel!
    @IBOutlet weak var number28: UILabel!
    @IBOutlet weak var number29: UILabel!
    @IBOutlet weak var number30: UILabel!
    
    
    @IBOutlet weak var alphabetA: UILabel!
    @IBOutlet weak var alphabetB: UILabel!
    @IBOutlet weak var alphabetC: UILabel!
    @IBOutlet weak var alphabetD: UILabel!
    @IBOutlet weak var alphabetE: UILabel!
    @IBOutlet weak var alphabetF: UILabel!
    @IBOutlet weak var alphabetG: UILabel!
    @IBOutlet weak var alphabetH: UILabel!
    @IBOutlet weak var alphabetI: UILabel!
    @IBOutlet weak var alphabetJ: UILabel!
    @IBOutlet weak var alphabetK: UILabel!
    @IBOutlet weak var alphabetL: UILabel!
    @IBOutlet weak var alphabetM: UILabel!
    @IBOutlet weak var alphabetN: UILabel!
    @IBOutlet weak var alphabetO: UILabel!
    @IBOutlet weak var alphabetP: UILabel!
    @IBOutlet weak var alphabetQ: UILabel!
    @IBOutlet weak var alphabetR: UILabel!
    @IBOutlet weak var alphabetS: UILabel!
    @IBOutlet weak var alphabetT: UILabel!
    @IBOutlet weak var alphabetU: UILabel!
    @IBOutlet weak var alphabetV: UILabel!
    @IBOutlet weak var alphabetW: UILabel!
    @IBOutlet weak var alphabetX: UILabel!
    @IBOutlet weak var alphabetY: UILabel!
    @IBOutlet weak var alphabetZ: UILabel!
   
    
    
    
    private func applyFilter() {
        number1.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number1.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number2.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number2.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number3.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number3.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number4.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number4.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number5.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number5.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number6.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number6.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number7.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number7.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number8.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number8.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number9.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number9.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number10.textColor = (number1Check.tag == SELECTED) ? .blue : .black
        number10.accessibilityTraits = (number1Check.tag == SELECTED) ?  .selected : .none
        
        number11.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number11.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number12.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number12.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number13.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number13.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number14.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number14.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number15.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number15.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number16.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number16.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number17.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number17.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number18.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number18.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number19.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number19.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number20.textColor = (number2Check.tag == SELECTED) ? .blue : .black
        number20.accessibilityTraits = (number2Check.tag == SELECTED) ?  .selected : .none
        
        number21.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number21.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number22.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number22.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number23.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number23.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number24.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number24.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number25.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number25.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number26.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number26.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number27.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number27.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number28.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number28.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number29.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number29.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        number30.textColor = (number3Check.tag == SELECTED) ? .blue : .black
        number30.accessibilityTraits = (number3Check.tag == SELECTED) ?  .selected : .none
        
        
        
        alphabetA.textColor = (alphabet1Radio.tag == SELECTED) ? .blue : .black
        alphabetA.accessibilityTraits = (alphabet1Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetB.textColor = (alphabet1Radio.tag == SELECTED) ? .blue : .black
        alphabetB.accessibilityTraits = (alphabet1Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetC.textColor = (alphabet1Radio.tag == SELECTED) ? .blue : .black
        alphabetC.accessibilityTraits = (alphabet1Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetD.textColor = (alphabet1Radio.tag == SELECTED) ? .blue : .black
        alphabetD.accessibilityTraits = (alphabet1Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetE.textColor = (alphabet1Radio.tag == SELECTED) ? .blue : .black
        alphabetE.accessibilityTraits = (alphabet1Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetF.textColor = (alphabet2Radio.tag == SELECTED) ? .blue : .black
        alphabetF.accessibilityTraits = (alphabet2Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetG.textColor = (alphabet2Radio.tag == SELECTED) ? .blue : .black
        alphabetG.accessibilityTraits = (alphabet2Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetH.textColor = (alphabet2Radio.tag == SELECTED) ? .blue : .black
        alphabetH.accessibilityTraits = (alphabet2Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetI.textColor = (alphabet2Radio.tag == SELECTED) ? .blue : .black
        alphabetI.accessibilityTraits = (alphabet2Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetJ.textColor = (alphabet2Radio.tag == SELECTED) ? .blue : .black
        alphabetJ.accessibilityTraits = (alphabet2Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetK.textColor = (alphabet3Radio.tag == SELECTED) ? .blue : .black
        alphabetK.accessibilityTraits = (alphabet3Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetL.textColor = (alphabet3Radio.tag == SELECTED) ? .blue : .black
        alphabetL.accessibilityTraits = (alphabet3Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetM.textColor = (alphabet3Radio.tag == SELECTED) ? .blue : .black
        alphabetM.accessibilityTraits = (alphabet3Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetN.textColor = (alphabet3Radio.tag == SELECTED) ? .blue : .black
        alphabetN.accessibilityTraits = (alphabet3Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetO.textColor = (alphabet3Radio.tag == SELECTED) ? .blue : .black
        alphabetO.accessibilityTraits = (alphabet3Radio.tag == SELECTED) ?  .selected : .none
        
        alphabetP.textColor = (alphabet3Radio.tag == SELECTED) ? .blue : .black
        alphabetP.accessibilityTraits = (alphabet3Radio.tag == SELECTED) ?  .selected : .none
        
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
    
    
    /*
     숫자, 알파벳 섹션 펼치기 접기
     */
    
    @IBOutlet weak var alphabetSectionlabel: UILabel!
    
    @IBOutlet weak var numberSectionlabel: UILabel!
    
    private func initNumberSection() {
       
        numberSection.isUserInteractionEnabled = true
        numberSection.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNumberSectionClicked)))
        numberSectionlabel.accessibilityTraits = .button
        //숫자 섹션을 펼침
        numberSection.tag = SELECTED
        numberSectionlabel.accessibilityHint = "접기"
    }
    
    
    @objc func onNumberSectionClicked(){
        if (numberSection.tag == UNSELECTED) {
            openNumberSection()
     
        } else if (numberSection.tag == SELECTED ) {
            closeNumberSection()
        
        }
    }
    
    private func initAlphabetSection() {
        alphabetSection.isUserInteractionEnabled = true
        alphabetSection.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAlphabetSectionClicked)))
        alphabetSectionlabel.accessibilityTraits = .button
        //알파벳 섹션을 접음
        alphabetSection.tag = UNSELECTED
        alphabetSectionlabel.accessibilityHint = "펼치기"
    }
    
    
    
    @objc func onAlphabetSectionClicked(){
        
        if (alphabetSection.tag == UNSELECTED) {
            openAlphabetSection()
        } else if (alphabetSection.tag == SELECTED ) {
            closeAlphabetSection()
        }
    }
    
    private func openAlphabetSection() {
        if (Constants.isAccessibilityApplied) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                UIAccessibility.post(notification: .announcement , argument: "알파벳 필터 펼침")
            })
            
            alphabetSection.accessibilityHint = "접기"
            
        }
        
        alphabet1Label.isHidden = false
        alphabet2Label.isHidden = false
        alphabet3Label.isHidden = false
        
        alphabet1Radio.isHidden = false
        alphabet2Radio.isHidden = false
        alphabet3Radio.isHidden = false
        
        alphabet1HeightConstraint.constant = 60
        alphabet2HeightConstraint.constant = 60
        alphabet3HeightConstraint.constant = 60
        
        alphabetSection.tag = SELECTED
    }
    
    private func closeAlphabetSection() {
        if (Constants.isAccessibilityApplied) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                UIAccessibility.post(notification: .announcement  , argument: "알파벳 필터 접음")
            })
            
            alphabetSection.accessibilityHint = "펼치기"
            
        }
        
        alphabet1Label.isHidden = true
        alphabet2Label.isHidden = true
        alphabet3Label.isHidden = true
        
        alphabet1Radio.isHidden = true
        alphabet2Radio.isHidden = true
        alphabet3Radio.isHidden = true
        
        
        alphabet1HeightConstraint.constant = 0
        alphabet2HeightConstraint.constant = 0
        alphabet3HeightConstraint.constant = 0
        
        alphabetSection.tag = UNSELECTED
        
    }
    
    private func closeNumberSection() {
        
        if (Constants.isAccessibilityApplied) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                UIAccessibility.post(notification: .announcement  , argument: "숫자 필터 접음")
            })
            
            numberSectionlabel.accessibilityHint = "펼치기"
            
        }
        
        
        number1Label.isHidden = true
        number2Label.isHidden = true
        number3Label.isHidden = true
        
        number1Check.isHidden = true
        number2Check.isHidden = true
        number3Check.isHidden = true
        
        
        number1HeightConstraint.constant = 60
        number2HeightConstraint.constant = 60
        number3HeightConstraint.constant = 60
        
        numberSection.tag = UNSELECTED
        
    }
    
    private func openNumberSection() {
        if (Constants.isAccessibilityApplied) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                //.layoutChanged는 음성 안내를 안함
                UIAccessibility.post(notification: .announcement , argument: "숫자 필터 펼침")
            })
            
            numberSectionlabel.accessibilityHint = "접기"
            
        }
        number1Label.isHidden = false
        number2Label.isHidden = false
        number3Label.isHidden = false
        
        number1Check.isHidden = false
        number2Check.isHidden = false
        number3Check.isHidden = false
        
        
        
        number1HeightConstraint.constant = 60
        number2HeightConstraint.constant = 60
        number3HeightConstraint.constant = 60
        
        numberSection.tag = SELECTED
        
    }
    
    
    
    
    /*
     숫자 check 버튼
     */
    
    
    private func initNumberCheck() {
        
        number1Label.accessibilityTraits = .button
        number1Label.isUserInteractionEnabled = true
        number1Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNumber1CheckClicked)))
        number1Check.isUserInteractionEnabled = true
        number1Check.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNumber1CheckClicked)))
        
        number2Label.accessibilityTraits = .button
        number2Label.isUserInteractionEnabled = true
        number2Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNumber2CheckClicked)))
        number2Check.isUserInteractionEnabled = true
        number2Check.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNumber2CheckClicked)))
        
        number3Label.accessibilityTraits = .button
        number3Label.isUserInteractionEnabled = true
        number3Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNumber3CheckClicked)))
        number3Check.isUserInteractionEnabled = true
        number3Check.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNumber3CheckClicked)))
        
    }
    
    @objc func onNumber1CheckClicked(){
        
        if (number1Check.tag == SELECTED) {
            
            number1Check.image = UIImage(named: "uncheck")
            number1Check.tag = UNSELECTED
            
            if (Constants.isAccessibilityApplied) {
                number1Label.accessibilityTraits.remove(.selected)
            }
            
        } else if (number1Check.tag == UNSELECTED ){
            if (Constants.isAccessibilityApplied) {
                number1Label.accessibilityTraits.insert(.selected)
            }
            
            number1Check.image = UIImage(named: "check")
            number1Check.tag = SELECTED
        }
        
    }
    
    @objc func onNumber2CheckClicked(){
        if (number2Check.tag == SELECTED) {
            if (Constants.isAccessibilityApplied) {
                number2Label.accessibilityTraits.remove(.selected)
            }
            
            number2Check.image = UIImage(named: "uncheck")
            number2Check.tag = UNSELECTED
            
        } else if (number2Check.tag == UNSELECTED ){
            if (Constants.isAccessibilityApplied) {
                
                number2Label.accessibilityTraits.insert(.selected)
            }
            
            number2Check.image = UIImage(named: "check")
            number2Check.tag = SELECTED
            
            
        }
        
    }
    
    
    @objc func onNumber3CheckClicked(){
        if (number3Check.tag == SELECTED) {
            if (Constants.isAccessibilityApplied) {
                
                number3Label.accessibilityTraits.remove(.selected)
            }
            
            number3Check.image = UIImage(named: "uncheck")
            number3Check.tag = UNSELECTED
            
            
        } else if (number3Check.tag == UNSELECTED ){
            if (Constants.isAccessibilityApplied) {
                
                number3Label.accessibilityTraits.insert(.selected)
            }
            
            number3Check.image = UIImage(named: "check")
            number3Check.tag = SELECTED
            
            
        }
        
    }
    
    
    
    
    /*
     알파벳 radio 버튼
     */
    
    private func initAlphabetRadio() {
        
        alphabet1Label.accessibilityTraits = .button
        alphabet1Label.isUserInteractionEnabled = true
        alphabet1Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAlphabet1RadioClicked)))
        alphabet1Radio.isUserInteractionEnabled = true
        alphabet1Radio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAlphabet1RadioClicked)))
        
        alphabet2Label.accessibilityTraits = .button
        alphabet2Label.isUserInteractionEnabled = true
        alphabet2Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAlphabet2RadioClicked)))
        alphabet2Radio.isUserInteractionEnabled = true
        alphabet2Radio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAlphabet2RadioClicked)))
        
        alphabet3Label.accessibilityTraits = .button
        alphabet3Label.isUserInteractionEnabled = true
        alphabet3Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAlphabet3RadioClicked)))
        alphabet3Radio.isUserInteractionEnabled = true
        alphabet3Radio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAlphabet3RadioClicked)))
        
    }
    
    @objc func onAlphabet1RadioClicked(){
        
        if (alphabet1Radio.tag == UNSELECTED) {
            
            alphabet1Radio.image = UIImage(named: "radio_check")
            alphabet1Radio.tag = SELECTED
            
            alphabet2Radio.image = UIImage(named: "radio_uncheck")
            alphabet2Radio.tag = UNSELECTED
            
            alphabet3Radio.image = UIImage(named: "radio_uncheck")
            alphabet3Radio.tag = UNSELECTED
            
            if (Constants.isAccessibilityApplied) {
                alphabet1Label.accessibilityTraits.insert(.selected)
                alphabet2Label.accessibilityTraits.remove(.selected)
                alphabet3Label.accessibilityTraits.remove(.selected)
            }
        }
        
    }
    
    @objc func onAlphabet2RadioClicked(){
        
        if (alphabet2Radio.tag == UNSELECTED) {
            
            alphabet2Radio.image = UIImage(named: "radio_check")
            alphabet2Radio.tag = SELECTED
            
            alphabet1Radio.image = UIImage(named: "radio_uncheck")
            alphabet1Radio.tag = UNSELECTED
            
            alphabet3Radio.image = UIImage(named: "radio_uncheck")
            alphabet3Radio.tag = UNSELECTED
            
            if (Constants.isAccessibilityApplied) {
                alphabet2Label.accessibilityTraits.insert(.selected)
                
                alphabet1Label.accessibilityTraits.remove(.selected)
                alphabet3Label.accessibilityTraits.remove(.selected)
            }
            
        }
        
    }
    
    
    @objc func onAlphabet3RadioClicked(){
        
        if (alphabet3Radio.tag == UNSELECTED) {
            
            alphabet3Radio.image = UIImage(named: "radio_check")
            alphabet3Radio.tag = SELECTED
            
            
            alphabet1Radio.image = UIImage(named: "radio_uncheck")
            alphabet1Radio.tag = UNSELECTED
            
            alphabet2Radio.image = UIImage(named: "radio_uncheck")
            alphabet2Radio.tag = UNSELECTED
            
            if (Constants.isAccessibilityApplied) {
                alphabet3Label.accessibilityTraits.insert(.selected)
                alphabet1Label.accessibilityTraits.remove(.selected)
                alphabet2Label.accessibilityTraits.remove(.selected)
            }
            
        }
        
    }
    
    
    
    
}
