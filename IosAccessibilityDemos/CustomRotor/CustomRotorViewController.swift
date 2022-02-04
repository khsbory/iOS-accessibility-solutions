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
    
    let maxNumber: Int = 50
    var arrNumber: [Int] = []
    
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
            arrNumber.append(i)
        }
        
    }
    
    func initTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if Constants.isAccessibilityApplied {
            self.tableView.accessibilityCustomRotors = [self.customRotorForTableViewButton(elementIdentifier: "삭제")]
        }
        
    }
    
    /// TableView의 CustomRotor 생성 - 로터시킬 Element(Button)에 accessibilityIdentifier를 설정하여 생성하는 방법
    func customRotorForTableViewButton(elementIdentifier: String, rotorName: String = "") -> UIAccessibilityCustomRotor {
        
        // rotorName을 따로 지정하지 않을 경우, Identifier로 사용
        let name = rotorName.isEmpty ? elementIdentifier : rotorName
        
        let propertyRotorOption = UIAccessibilityCustomRotor(name: name) { (predicate) ->
            UIAccessibilityCustomRotorItemResult? in
            
            let currentButton = predicate.currentItem.targetElement as? UIButton
            let elementViews = self.getElementViews(elementIdentifier)
            let currentIndex = elementViews.firstIndex { $0 == currentButton }
            
            let targetIndex: Int
            switch predicate.searchDirection {
            case .previous:
                targetIndex = (currentIndex ?? 1) - 1
            case .next:
                targetIndex = (currentIndex ?? -1) + 1
            @unknown default:
                fatalError()
            }
            
            guard 0..<elementViews.count ~= targetIndex else { return nil }
            return UIAccessibilityCustomRotorItemResult(targetElement: elementViews[targetIndex], targetRange: nil)
        }
        
        return propertyRotorOption
    }
    
    /// accessibilityIdentifier를 사용하여, 로터를 생성할 Element 목록 반환
    func getElementViews(_ identifier: String) -> [UIView] {
        let cells = self.tableView.visibleCells
        
        var views: [UIView] = []
        for index in 0..<cells.count {
            if let cell = cells[index] as? CustomRotorCell {
                if let element = cell.contentView.subviews.first(where: { $0.accessibilityIdentifier == identifier }) {
                    views.append(element)
                }
            }
        }
        
        return views
    }
}

// MARK: - UITableView UITableViewDelegate, UITableViewDataSource
extension CustomRotorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrNumber.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomRotorCell", for: indexPath) as! CustomRotorCell
        cell.lblNumber.text = "\(arrNumber[indexPath.row])"
                
        if Constants.isAccessibilityApplied {
            cell.btnDelete.accessibilityLabel = "\(arrNumber[indexPath.row]) 삭제"
            
            // '삭제' 버튼에 대한 로터 생성을 위한 accessibilityIdentifier 설정
            cell.btnDelete.accessibilityIdentifier = "삭제"
            
            // 10의 단위로 accessibilityTextHeadingLevel 1로 설정
            if arrNumber[indexPath.row] % 10 == 0 {
                let attributes: [NSAttributedString.Key:Any] = [.accessibilityTextHeadingLevel: NSNumber(value: 1), .font: UIFont.boldSystemFont(ofSize: 20)]
                let text = NSAttributedString(string: "\(arrNumber[indexPath.row])", attributes: attributes)
                cell.lblNumber.attributedText = text
            }
        }
        return cell
        
    }
}
