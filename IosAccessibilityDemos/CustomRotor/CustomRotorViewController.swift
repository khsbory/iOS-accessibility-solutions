//
//  CustomRotorViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2022/01/18.
//  Copyright © 2022 Jeonggyu Park. All rights reserved.
//

import UIKit

class CustomRotorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let maxNumber: Int = 100
    var arrNumber: [String] = []
    
    var searchDistance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreenTitle()
        
        self.initArrayNumber()
        
        self.initTableView()
    }
    
    private func setScreenTitle() {
        
        if Constants.isAccessibilityApplied {
            self.title = "접근성이 적용된 경우"
        } else {
            self.title = "접근성이 적용되지 않은 경우"
        }
        
    }
    
    func initArrayNumber() {
        
        for i in 1..<maxNumber+1 {
            arrNumber.append("\(i)")
        }
        
    }
    
    func initTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if Constants.isAccessibilityApplied {
            self.tableView.accessibilityCustomRotors = [self.customRotor(name: "삭제")]
        }
        
    }
    
    /// CustomRotor 생성
    func customRotor(name: String) -> UIAccessibilityCustomRotor {
        
        let propertyRotorOption = UIAccessibilityCustomRotor(name: name) { (predicate) ->
            UIAccessibilityCustomRotorItemResult? in
            if let targetIndex = self.getAccessibilityFocusedTargetIndex(direction: predicate.searchDirection) {
                
                if targetIndex >= self.arrNumber.count || targetIndex < 0 {
                    return nil
                }
                
                let indexPath: IndexPath = IndexPath(row: targetIndex, section: 0)
                let cell: CustomRotorCell = self.tableView.cellForRow(at: indexPath) as! CustomRotorCell
                
                return UIAccessibilityCustomRotorItemResult(targetElement: cell.btnDelete, targetRange: nil)
            }
            return nil
        }
        
        return propertyRotorOption
    }
    
    /// Focus 할 TableView의 Index 반환
    private func getAccessibilityFocusedTargetIndex(direction:  UIAccessibilityCustomRotor.Direction) -> Int? {
        
        var targetIndex: Int?
        
        // TableView에서 포커스 중인 View 찾기
        for index in 0..<arrNumber.count {
            let indexPath: IndexPath = IndexPath(row: index, section: 0)
            
            if let cell: CustomRotorCell = self.tableView.cellForRow(at: indexPath) as? CustomRotorCell {
                // target 선정
                if cell.accessibilityElementIsFocused() {
                    targetIndex = direction == .next ? index : index - 1
                    return targetIndex
                } else if cell.btnDelete.accessibilityElementIsFocused() {
                    targetIndex = direction == .next ? index + 1 : index - 1
                    return targetIndex
                }
            }
        }
        return nil
    }
}

// MARK: - UITableView UITableViewDelegate, UITableViewDataSource
extension CustomRotorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrNumber.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomRotorCell", for: indexPath) as! CustomRotorCell
        cell.lblNumber.text = arrNumber[indexPath.row]
        
        if Constants.isAccessibilityApplied {
            cell.btnDelete.accessibilityLabel = "\(arrNumber[indexPath.row]) 삭제"
        }
        return cell
        
    }
}
