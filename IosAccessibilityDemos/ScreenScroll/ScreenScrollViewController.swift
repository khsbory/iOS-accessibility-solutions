//
//  ScreenScrollController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/04/15.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ScreenScrollViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var datas:Array<String> = Array()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        createTableData()
        initTable()
        initBackButton()
        
    }
    
    private func createTableData() {
        
        for i in 0..<500 {
            datas.append(String(i))
        }
        
    }
    
    private func initBackButton() {
        backButton.accessibilityTraits = .button
        backButton.isAccessibilityElement = true
        backButton.accessibilityLabel = "뒤로가기"
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBakButtonClicked)))
     }
    
    @objc func onBakButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    private func initTable() {
        
        self.table.register(TableCell.self, forCellReuseIdentifier: "cell")
        self.table.delegate = self
        self.table.dataSource = self
        self.table.rowHeight = 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
            ) as!TableCell
        cell.demoTitle = datas[indexPath.row]
        cell.layoutSubviews()
        cell.accessibilityTraits = .button
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.row == 0) {
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("index: ", indexPath.row)
        
        let firstVisibleIndexPath = tableView.indexPathsForVisibleRows?[0]
                
                print("top visible cell row  is \([firstVisibleIndexPath!.row])")
          
    
    
        if firstVisibleIndexPath!.row == 0 {
            backButton.isHidden = false
            
            if Constants.isAccessibilityApplied {
            backButton.isAccessibilityElement = false
            }
            
            
        } else {
            backButton.isHidden = true
            
            if Constants.isAccessibilityApplied {
            backButton.isAccessibilityElement = true
            }
           
            
            
        }
    }
  
    
}
