//
//  AccessibilityCalendarDemoViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/11/09.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class AccessibilityCalendarDemoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: DataTableCollectionView!
    
    var weeks: [String] = ["일","월","화","수","목","금","토"]
    var days: [String] = []
    
    var month = 11
    var daysCountInMonth = 30
    var weekdayAdding = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreenTitle()
        
        self.initDays()
        
        self.initCollectionView()
        
        if Constants.isAccessibilityApplied {
            self.initAccessibility()
        }
    }
    
    private func setScreenTitle() {
        self.title = "접근성이 적용된 경우"
    }
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func initDays() {
        self.days.removeAll()
        
            for day in self.weekdayAdding...self.daysCountInMonth {
            if day < 1 { // 1보다 작을 경우는 비워줘야 하기 때문에 빈 값을 넣어준다.
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
            
        }
    }
    
    func initAccessibility() {
        self.collectionView.columnCount = weeks.count
        self.collectionView.rowCount = ( days.count / 7 ) + 2
        
//        self.collectionView.isRowReaderOn = true
//        self.collectionView.isColumnReaderOn = true
        
        self.collectionView.headerCellCount = weeks.count
        for _ in 0..<weeks.count {
            self.collectionView.headerCells.append(DataTableCalendarCell())
        }
        
        self.collectionView.initDataTable()
    }
}
extension AccessibilityCalendarDemoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // 요일 섹션과 일 섹션
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataTableCalendarCell", for: indexPath) as? DataTableCalendarCell else {
            fatalError("Expected a `\(DataTableCalendarCell.self)` but did not receive one.")
        }
        
        switch indexPath.section {
        case 0:
            cell.label.text = weeks[indexPath.row]
        default:
            cell.label.text = days[indexPath.row]
        }
        
        if indexPath.row % 7 == 0 { // 일요일
            cell.label.textColor = .red
        } else if indexPath.row % 7 == 6 { // 토요일
            cell.label.textColor = .blue
        } else {
            cell.label.textColor = .black
        }
        
        if Constants.isAccessibilityApplied {
            let row = indexPath.section == 0 ? indexPath.row : indexPath.row + 7
            cell.row = ( row / 7 )
            cell.column = row % 7
            cell.rowLength = ( days.count / 7 ) + 2
            cell.columnLength = weeks.count
            
            if indexPath.section == 0 {
                print("\(self.collectionView.headerCells)")
                self.collectionView.headerCells[indexPath.row] = cell
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds: CGFloat = UIScreen.main.bounds.size.width
        
        let cellSize: CGFloat = bounds / 7
        
        return CGSize(width: cellSize, height: cellSize)
        
    }
}
