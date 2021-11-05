//
//  DataTableViewController.swift
//  IosAccessibilityDemos
//
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

struct TableData {
    var name: String
    var kor: String
    var eng: String
    var math: String
}

class DataTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var headerArray: [String] = []
    var dataArray: [TableData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreenTitle()
        
        self.initArray()
        self.initTableView()
    }
    
    
    private func setScreenTitle() {
        if Constants.isAccessibilityApplied {
            self.title = "접근성이 적용된 경우"
        } else {
            self.title = "접근성이 적용되지 않은 경우"
        }
    }
        
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func initArray() {
        headerArray = ["성명","국어","영어","수학"]
        
        dataArray.append(TableData(name: "홍길동",kor: "80",eng: "80",math: "100"))
        dataArray.append(TableData(name: "홍길순",kor: "75",eng: "100",math: "100"))
        dataArray.append(TableData(name: "김철수",kor: "90",eng: "85",math: "85"))
        
        self.tableView.reloadData()
    }
}

// MARK:- UITableView UITableViewDelegate, UITableViewDataSource
extension DataTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection \(dataArray.count + 1)")
        return dataArray.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("indexPath \(indexPath.row)")
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataHeaderTableViewCell", for: indexPath) as! DataHeaderTableViewCell
            cell.setArrayData(array: self.headerArray)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
            cell.setArrayData(data: self.dataArray[indexPath.row - 1])
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height =  (UIScreen.main.bounds.width - 20.0) / 4
        if indexPath.row == 0 {
            height = height / 2
        }
        return height
    }
    
}
