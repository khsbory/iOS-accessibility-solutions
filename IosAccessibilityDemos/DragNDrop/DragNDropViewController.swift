//
//  DragNDropViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/02/04.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class DragNDropViewController: UIViewController, DragNDropPopupDelegate {
    func onPopupClosed() {
        UIAccessibility.post(notification: .layoutChanged, argument: self.addButton)
    }
    @IBOutlet weak var container: UIView!
    //@IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addButton: UIButton!
    private var stackView: UIStackView?
    private var itemCount: Int = 0
    private var myDic = Dictionary<Int, Bool>()
    @IBOutlet weak var deleteSelectAllButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.accessibilityTraits = [.startsMediaSession,.button]
        showPopup()
        initStackView()
        initDeleteSelectAllButton()
        
    }
    
    private func initDeleteSelectAllButton() {
        
        deleteSelectAllButton.isHidden = true
        deleteSelectAllButton.isUserInteractionEnabled = true
        deleteSelectAllButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteAllSelect)))
    }
    
    
    @objc func deleteAllSelect() -> Bool {
        myDic.removeAll()
        
        if (Constants.isAccessibilityApplied) {
            annouceAccessibility(message: "선택 삭제되었습니다.")
            
        }
   
        return true
    
    }
    
    
    
    
    private func showPopup() {
            let storyboard = UIStoryboard(name: "DragNDropPopup", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "drag_n_drop_popup")
        (viewController as! DragNDropPopupController).popupDelegate  = self
           self.present(viewController, animated: true, completion: nil)
    }
    
    
    private func initStackView() {
        
        //Stack View
        stackView   = UIStackView()
        stackView?.axis  = NSLayoutConstraint.Axis.vertical
        stackView?.distribution  = UIStackView.Distribution.equalSpacing
        stackView?.alignment = UIStackView.Alignment.center
        stackView?.spacing   = 16.0
       
        stackView?.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView!)
         
        stackView?.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 50).isActive = true
     
    }
    
    
    private func addItem() {
      
        
        print("plusapps addItem 1")
        itemCount = itemCount + 1

        let screenWidth = UIScreen.main.bounds.width
        let item = UIView()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        item.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        item.backgroundColor = .gray
        
        stackView?.addArrangedSubview(item)
        
        let selectButton = UIButton()
        let deleteButton = UIButton()
        let numberText = UILabel()
        let handleButton = UIImageView()
        //addSubview를 하고 anchor를 지정하지 않으면 강종되는 듯
        item.addSubview(selectButton)
        item.addSubview(deleteButton)
        item.addSubview(numberText)
        item.addSubview(handleButton)
        
        //translatesAutoresizingMaskIntoConstraints = false를 지정해야 view가 표시되는 듯
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        numberText.translatesAutoresizingMaskIntoConstraints = false
        handleButton.translatesAutoresizingMaskIntoConstraints = false


        selectButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.leftAnchor.constraint(equalTo: item.leftAnchor, constant: 20).isActive = true
        selectButton.centerYAnchor.constraint(equalTo: item.centerYAnchor).isActive = true
        selectButton.setTitle("선택해제", for: .normal)
        selectButton.backgroundColor = .blue
        
        
        selectButton.isHidden = true
        
        
        
        
    
        deleteButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.leftAnchor.constraint(equalTo: selectButton.rightAnchor, constant: 20).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: item.centerYAnchor).isActive = true
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.backgroundColor = .blue
        
        
        deleteButton.isAccessibilityElement = false
        
//
//        if (Constants.isAccessibilityApplied) {
//            deleteButton.isAccessibilityElement = false
//        }
        
        numberText.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        numberText.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        numberText.centerXAnchor.constraint(equalTo: item.centerXAnchor).isActive = true
        numberText.centerYAnchor.constraint(equalTo: item.centerYAnchor).isActive = true

        numberText.text = String(itemCount)
        
        
        
      
        handleButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        handleButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        handleButton.rightAnchor.constraint(equalTo: item.rightAnchor, constant: -20).isActive = true
        handleButton.centerYAnchor.constraint(equalTo: item.centerYAnchor).isActive = true

        handleButton.image = UIImage(named: "handle_button")
        
        item.tag = itemCount
        
        if (Constants.isAccessibilityApplied) {
            annouceAccessibility(message: String(self.itemCount) + "추가됨")
        
 
           // numberText.accessibilityTraits = .button
            //numberText.isAccessibilityElement = true
            //numberText.accessibilityLabel = "뒤로가기"
            numberText.isUserInteractionEnabled = true
            numberText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleItem)))
            
            
            
            
            
            
            item.accessibilityCustomActions = [
                
                UIAccessibilityCustomAction(
                        name: "삭제",
                        target: self,
                        selector: #selector(deleteItem)
                    ),
                    UIAccessibilityCustomAction(
                        name: "위로 이동",
                        target: self,
                        selector: #selector(moveUpItem)
                    ),
                UIAccessibilityCustomAction(
                    name: "아래로 이동",
                    target: self,
                    selector: #selector(moveDownItem)
                )
            ]
        }
        
    }
    
    @objc func toggleItem() -> Bool {
        let view = getAccessibilityFocusedItem()
        print("plusapps toggleItem")
        let index = getIndexInStackView(subview: view!)
        
        let isSelected = myDic[index]
        
        if (isSelected == nil || isSelected == false) {
            myDic[index] = true
            annouceAccessibility(message: String(index + 1) + " 항목 선택됨")
            
        } else {
            myDic[index] = false
            annouceAccessibility(message: String(index + 1) + " 항목 선택해제됨")
            
        }
        
        var hasSelectedItem = false
        
        for value in myDic.values {
            
            if (value == true) {
                hasSelectedItem = true
                break
            }
            print("\(value)")
             
        }

        deleteSelectAllButton.isHidden = !hasSelectedItem
        
        
       
        return true
    
    }
    
    
    @objc func deleteItem() -> Bool {
        let view = getAccessibilityFocusedItem()
        print("plusapps deleteItem")
        let index = getIndexInStackView(subview: view!)
        
        var newIndex = index - 1
        if (newIndex < 0) {
            newIndex = 0
        }
       
        //stackView?.removeArrangedSubview를 사용하면 삭제가 제대로 안되는 듯
        //removeFromSuperview를 사용해야 하는 듯
        view!.removeFromSuperview()
        //stackView?.removeArrangedSubview(view!)
        annouceAccessibility(message: String(view!.tag) + "삭제됨")
        
        
        
        //이전 view에 초점을 맞춤
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            UIAccessibility.post(notification: .layoutChanged, argument: self.stackView?.arrangedSubviews[newIndex])
         
        })
       
        return true
    
    }
    
    @objc func moveUpItem() -> Bool{
        let view = getAccessibilityFocusedItem()
        print("plusapps moveUpItem")
        let index = getIndexInStackView(subview: view!)
        
        
        if (index == 0) {
            annouceAccessibility(message: "위로 이동할 수 없음")
                  return true
        }
        
        
        
        print("index", index)
        let newIndex = index - 1
        stackView?.insertArrangedSubview(view!, at: newIndex)
        
        annouceAccessibility(message: String(stackView!.arrangedSubviews[index].tag) + "위로 이동됨")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            UIAccessibility.post(notification: .layoutChanged, argument: self.stackView?.arrangedSubviews[newIndex])
         
        })
        return true
     
    }
    

    @objc func moveDownItem() -> Bool{
        //UIAccessibilityCustomAction에서는 sender.view를 사용할 수 없는 듯
        //접근성이 초점맞춰진 view를 가져옴
       
        let view = getAccessibilityFocusedItem()

        print("plusapps moveDownItem")
        
        let index = getIndexInStackView(subview: view!)


        if (index == stackView!.arrangedSubviews.count - 1) {
            annouceAccessibility(message: "아래로 이동할 수 없음")
                  return true
        }



        print("index", index)
        let newIndex = index + 1
        stackView?.insertArrangedSubview(view!, at: newIndex)

        annouceAccessibility(message: String(stackView!.arrangedSubviews[index].tag) + "아래로 이동됨")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            UIAccessibility.post(notification: .layoutChanged, argument: self.stackView?.arrangedSubviews[newIndex])
         
        })
        return true


    }
    
    private func getAccessibilityFocusedItem() -> UIView? {
        let subview: UIView = UIAccessibility.focusedElement(using: UIAccessibility.AssistiveTechnologyIdentifier.notificationVoiceOver) as! UIView
        let view = subview.superview
        
        return view
    }
    
    
    private func annouceAccessibility(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            UIAccessibility.post(notification: .announcement , argument: message)
         
        })
    }
    
    private func getIndexInStackView(subview: UIView) -> Int {
        var index = 0
        for view in stackView!.arrangedSubviews {
            if (view == subview) {
             return index
            }
            index = index + 1
        }
        
        return index
    }
    

    @IBAction func handleAddButtonClick(_ sender: Any) {
        addItem()
    }
}
