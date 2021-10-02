//
//  NewDragNDropViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/06/22.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit
protocol NewDragNDropDelegate {
    func selectFavorite(number: Int)
    func deselectFavorite(number: Int)
    func deleteItem(number: Int)
    func showMorePopup(number: Int)
}

class NewDragNDropViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var numberArray: Array<Int> = []
    var noneFavoriteArray: Array<Int> = []
    var selectNumberArray: Array<Int> = [] {
        didSet {
            self.setDeleteButton()
        }
    }
    
    var selectFavoriteArray: Array<Int> = []
    
    var popup: NewDragNDropPopup?
    
    @IBAction func onDeleteButtonClicked(_ sender: Any) {
        self.deleteSelectArray()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreenTitle()
        
        self.initNumberArray()
        self.initNoneFavoriteArray()
        self.initTableView()
        self.initLongPressGesture()
    }
    
    private func setScreenTitle() {
        if Constants.isAccessibilityApplied {
            self.title = "접근성이 적용된 경우"
        } else {
            self.title = "접근성이 적용되지 않은 경우"
        }
    }
    
    func setDeleteButton() {
        
        if self.deleteButton.isHidden && selectNumberArray.count > 0 {
            self.deleteButton.isHidden = false
            if Constants.isAccessibilityApplied {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    UIAccessibility.post(notification: .announcement, argument: "\(self.deleteButton.titleLabel?.text ?? "삭제") 버튼 표시됨")
                }
            }
        } else if !self.deleteButton.isHidden && selectNumberArray.count == 0 {
            self.deleteButton.isHidden = true
        }
        
    }
    
    func initNumberArray() {
        for i in 1..<31 {
            numberArray.append(i)
        }
    }
    
    func initNoneFavoriteArray() {
        noneFavoriteArray.append(10)
        noneFavoriteArray.append(11)
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initLongPressGesture() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "NewDragNDrop", bundle: nil)
        popup = storyBoard.instantiateViewController(withIdentifier: "NewDragNDropPopup") as? NewDragNDropPopup
            
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        self.tableView.addGestureRecognizer(longPress)
        
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
                let touchPoint = sender.location(in: self.tableView)
                if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                    let number = numberArray[indexPath.row]
                    print("🔵 TableView LongPressGesture - number : \(number)")
                }
            }
        self.showPopup()
    }
    
    func showPopup() {
        if let popVC = self.popup {
            popVC.showAnim(vc: self, parentAddView: self.view) {
            }
        }
    }
        
    @objc func showAlert() {
        
        let alert = UIAlertController(title: "", message: "감사합니다", preferredStyle: .alert)
        let completeAction = UIAlertAction(title: "확인", style: .default) { action in
        }
        alert.addAction(completeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectNumber(number: Int) {
        if !self.selectNumberArray.exists(number) {
            self.selectNumberArray.append(number)
        }
    }
    
    func deselectNumber(number: Int) {
        if self.selectNumberArray.exists(number) {
            selectNumberArray = selectNumberArray.removed(number)
        }
    }
    
    func deleteSelectArray() {
        for i in 0..<selectNumberArray.count {
            if let index = numberArray.indexOf(selectNumberArray[i]) {
                numberArray.remove(at: index)
            }
        }
        self.selectNumberArray.removeAll()
        self.tableView.reloadData()
        
        if Constants.isAccessibilityApplied {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                UIAccessibility.post(notification: .announcement, argument: "삭제 완료")
            }
        }
    }
    
    // MARK: WithAccessibility
    
}
extension NewDragNDropViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewDragNDropTableViewCell", for: indexPath) as! NewDragNDropTableViewCell
        
        let number = numberArray[indexPath.row]
        
        cell.number = number
        cell.numberLabel.text = "\(number)"
        cell.isSelected = self.selectNumberArray.exists(number)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.showAlert))
        cell.addGestureRecognizer(recognizer)
        
        if noneFavoriteArray.exists(numberArray[indexPath.row]) {
            cell.favoriteButton.isHidden = true
            cell.favoriteButton.isEnabled = false
        } else {
            // 관심 버튼 세팅
            cell.favoriteButton.isSelected = self.selectFavoriteArray.exists(number)
            cell.delegate = self
            cell.favoriteButton.isHidden = false
            cell.favoriteButton.isEnabled = true
        }
        
        if Constants.isAccessibilityApplied {
            cell.setAccessibility()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = self.getSelectRowAction(indexPath: indexPath)
            return UISwipeActionsConfiguration(actions: [action])
    }

    func getSelectRowAction(indexPath: IndexPath) -> UIContextualAction {
        
        let number = self.numberArray[indexPath.row]
               
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            if self.selectNumberArray.exists(number) {
                self.deselectNumber(number: number)
                if Constants.isAccessibilityApplied {
                    UIAccessibility.post(notification: .announcement, argument: "해제됨")
                }
            } else {
                self.selectNumber(number: number)
                if Constants.isAccessibilityApplied {
                    UIAccessibility.post(notification: .announcement, argument: "선택됨")
                }
            }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        // 210924. 데모 디벨롭 aciton title 삭제 요청
        let title = self.selectNumberArray.exists(number) ? "해제" : "선택"
//        action.title = title
        if Constants.isAccessibilityApplied {
            action.accessibilityLabel = title
        }
        
        // title 대신 image 삽입
        let name = self.selectNumberArray.exists(number) ? "check" : "uncheck"
        
        
        return action
    }
    
}
extension NewDragNDropViewController: NewDragNDropDelegate {
    func showMorePopup(number: Int) {
        self.showPopup()
    }
    
    func selectFavorite(number: Int) {
        if !self.selectFavoriteArray.exists(number) {
            self.selectFavoriteArray.append(number)
        }
    }
    
    func deselectFavorite(number: Int) {
        if self.selectFavoriteArray.exists(number) {
            selectFavoriteArray = selectFavoriteArray.removed(number)
        }
    }
    
    func deleteItem(number: Int) {
        
        if let index = numberArray.indexOf(number) {
            numberArray.remove(at: index)
        }
//        self.selectNumberArray.removeAll()
        self.tableView.reloadData()
        
        if Constants.isAccessibilityApplied {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                UIAccessibility.post(notification: .announcement, argument: "삭제 완료")
            }
        }
    }
}
extension Array where Element: Equatable {
    
    /**
     # exists
     - Author: suni
     - Parameters:
     - item: Array의 Element
     - Returns: Bool
     - Note: 배열 안에 해당 item의 존재 여부를 반환
     */
    public func exists(_ item: Element) -> Bool {
        if let _ = self.indexOf(item) {
            return true
        }
        return false
    }
    
    /**
     # indexOf
     - Author: suni
     - Parameters:
     - item: 인덱스를 반환할 해당 Array의 Element
     - Returns: Int?
     - Note: 해당 Element의 인덱스를 반환. 존재하지 않으면 nil 반환
     */
    public func indexOf(_ item: Element) -> Int? {
        return self.enumerated().filter({ $0.element == item }).map({ $0.offset }).first
    }
    
    /**
     # remove
     - Author: suni
     - Parameters:
     - item: 제거할 Array의 Element
     - Returns: Int?
     - Note: item을 제거하고 해당 값을 반환
     */
    public mutating func remove(item: Element) -> Element? {
        if let index = indexOf(item) {
            return self.remove(at: index)
        }
        return nil
    }
    
    /**
     # removed
     - Author: suni
     - Parameters:
     - item: Array의 Element
     - Returns: Bool
     - Note: item을 제거한 배열을 반환
     */
    public func removed(_ item: Element) -> [Element] {
        return self.filter({ $0 != item })
    }
}
