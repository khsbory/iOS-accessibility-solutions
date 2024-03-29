//
//  SecondPageViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/01/18.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit
import NVAccessibilitySolution

class SecondPageViewController:  UIViewController , UITableViewDelegate, UITableViewDataSource{
    var vegetables:[String] =
        ["시금치", "콩나물", "토마토", "콩", "치나물", "오이", "배추", "고구마", "감자", "부추"]
   
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        initTables()
    }
    
    private func sayScreenNameForAccessibility(screenName: String?) {
        // 211125. 라이브러리 사용
        NVAccessibility.announceForAccessiblity(screenName,.now() + 0.1)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//
//                             UIAccessibility.post(notification: .announcement, argument: screenName)
//                          })
    }
    
    private func initTables() {
        
        self.tableView.register(VegetableTableCell.self, forCellReuseIdentifier: "vegetableTableCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60
        
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vegetables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "vegetableTableCell",
                for: indexPath
                ) as! VegetableTableCell
        cell.vegetableName = vegetables[indexPath.row]
        cell.layoutSubviews()
        cell.backgroundColor = .orange
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     }
    
}
