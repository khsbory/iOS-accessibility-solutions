//
//  AccessibilityFocusDemoWithoutAViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2020/12/04.
//  Copyright © 2020 Jeonggyu Park. All rights reserved.
//

import UIKit

class AccessibilityFocusDemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fruits:[String] =
        ["사과", "배", "바나나", "딸기", "오렌지", "키위", "수박", "멜론", "참외", "파인애플"]
    var vegetables:[String] =
        ["시금치", "콩나물", "토마토", "콩", "치나물", "오이", "배추", "고구마", "감자", "부추"]
    
    @IBOutlet weak var fruitTable: UITableView!
    
    @IBOutlet weak var vegetableTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initTables()
        setScreenTitle()
    }
    
    private func setScreenTitle() {
        self.title = Constants.isAccessibilityApplied ? "접근성이 적용된 경우" : "접근성이 적용되지 않은 경우"
    }
    
    private func initTables() {
        
        self.fruitTable.register(FruitTableCell.self, forCellReuseIdentifier: "fruitTableCell")
        self.fruitTable.delegate = self
        self.fruitTable.dataSource = self
        self.fruitTable.rowHeight = 60
        
        
        self.vegetableTable.register(VegetableTableCell.self, forCellReuseIdentifier: "vegetableTableCell")
        self.vegetableTable.delegate = self
        self.vegetableTable.dataSource = self
        self.vegetableTable.rowHeight = 60
        
        if (Constants.isAccessibilityApplied) {
            fruitTable.accessibilityLabel = "과일리스트"
            vegetableTable.accessibilityLabel = "채소리스트"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == fruitTable) {
            return fruits.count
        } else if (tableView == vegetableTable) {
            return vegetables.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == fruitTable) {
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "fruitTableCell",
                    for: indexPath
                    ) as! FruitTableCell
            cell.fruitName = fruits[indexPath.row]
            cell.layoutSubviews()
            return cell
        } else if (tableView == vegetableTable) {
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "vegetableTableCell",
                    for: indexPath
                    ) as! VegetableTableCell
            cell.vegetableName = vegetables[indexPath.row]
            cell.layoutSubviews()
            return cell
        }
        
        return UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     }
    
   
}


