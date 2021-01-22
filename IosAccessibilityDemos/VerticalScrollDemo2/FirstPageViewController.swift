//
//  FirstPageViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/01/18.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//
import UIKit

class FirstPageViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var fruits:[String] =
        ["사과", "배", "바나나", "딸기", "오렌지", "키위", "수박", "멜론", "참외", "파인애플"]
   
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        initTables() 
        if (Constants.isAccessibilityApplied) {
        sayScreenNameForAccessibility(screenName: "과일화면")
        }
    }
    
    private func sayScreenNameForAccessibility(screenName: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                              
                             UIAccessibility.post(notification: .pageScrolled , argument: screenName)
                          })
    }
    
    private func initTables() {
        
        self.tableView.register(FruitTableCell.self, forCellReuseIdentifier: "fruitTableCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60
        
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "fruitTableCell",
                for: indexPath
                ) as! FruitTableCell
        cell.fruitName = fruits[indexPath.row]
        cell.layoutSubviews()
        cell.backgroundColor = .green
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     }
    
  
}
