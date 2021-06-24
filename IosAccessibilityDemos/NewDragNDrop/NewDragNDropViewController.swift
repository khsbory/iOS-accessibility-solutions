//
//  NewDragNDropViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/06/22.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class NewDragNDropViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var numberArray: Array<Int> = []
    var selectNumberArray: Array<Int> = [] {
        didSet {
            self.setDeleteButton()
        }
    }
    
    @IBAction func onDeleteButtonClicked(_ sender: Any) {
        self.deleteSelectArray()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNumberArray()
        self.initTableView()
        
        if Constants.isAccessibilityApplied {
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
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
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
        
        cell.numberLabel.text = "\(number)"
        cell.isSelected = self.selectNumberArray.exists(number)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.showAlert))
        cell.addGestureRecognizer(recognizer)
        
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
        
        let title = self.selectNumberArray.exists(number) ? "해제" : "선택"
        action.title = title
        action.backgroundColor = .blue
        
        return action
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
