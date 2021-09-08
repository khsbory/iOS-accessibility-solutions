//
//  VoiceOverScrollTestViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/08/04.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class VoiceOverScrollTestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var numberArray: Array<Int> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNumberArray()
        self.initTableView()
        
        
        if Constants.isAccessibilityApplied {
            self.initAccessibility()
        }
    }
    
    
    func initNumberArray() {
        for i in 1..<31 {
            numberArray.append(i)
        }
    }
    
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
    }

    func initAccessibility() {
    }
}
extension VoiceOverScrollTestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 19 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoiceOverScrollTestWebViewCell", for: indexPath) as! VoiceOverScrollTestWebViewCell
            
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoiceOverScrollTestTableViewCell", for: indexPath) as! VoiceOverScrollTestTableViewCell
            
            cell.numberLabel.text = "\(numberArray[indexPath.row])"
        
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 19 {
            return 700.0
        } else{
            return 70.0
        }
    }

}

