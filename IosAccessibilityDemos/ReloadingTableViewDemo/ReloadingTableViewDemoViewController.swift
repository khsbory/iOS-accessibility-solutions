//
//  ReloadingTableViewDemoViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/10/07.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReloadingTableViewDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var minNumber: Int = 1
    var maxNumber: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreenTitle()
        
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

}

// MARK:- UITableView UITableViewDelegate, UITableViewDataSource
extension ReloadingTableViewDemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReloadingButtonCell", for: indexPath) as! ReloadingButtonCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReloadingTableViewCell", for: indexPath) as! ReloadingTableViewCell
            cell.minNumber = self.minNumber
            cell.maxNumber = self.maxNumber
            cell.setNumberArray()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60.0
        } else {
            let height = self.view.bounds.height - 60.0 - topbarHeight
            return height
        }
    }
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
}
