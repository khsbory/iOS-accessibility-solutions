//
//  CalendarDemoViewController.swift
//  IosAccessibilityDemos
//
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class CalendarDemoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    }
    
    private func setScreenTitle() {
        self.title = "접근성이 적용되지 않은 경우"
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
}
extension CalendarDemoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else {
            fatalError("Expected a `\(CalendarCell.self)` but did not receive one.")
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds: CGFloat = UIScreen.main.bounds.size.width
        
        let cellSize: CGFloat = bounds / 7
        
        return CGSize(width: cellSize, height: cellSize)
        
    }
}
