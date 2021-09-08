//
//  ReadjustFocusViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/07/27.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReadjustFocusViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var footerButton: UIButton!
    @IBOutlet weak var footerPlusButton: UIButton!
    
    var numberArray: Array<Int> = []
    var isPlusMode: Bool = false

    @IBAction func onCloseButtonClicked(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onMoreButtonClicked(_ sender: Any) {
        self.showAlert()
    }
    
    @IBAction func onDefaultModeButtonClicked(_ sender: Any) {
        if Constants.isAccessibilityApplied {
            self.footerButton.accessibilityTraits.insert(.selected)
            self.footerPlusButton.accessibilityTraits.remove(.selected)
        }
        
        self.isPlusMode = false
        self.tableView.reloadData()
    }
    
    @IBAction func onPlusModeButtonClicked(_ sender: Any) {
        if Constants.isAccessibilityApplied {
            self.footerPlusButton.accessibilityTraits.insert(.selected)
            self.footerButton.accessibilityTraits.remove(.selected)
        }
        
        self.isPlusMode = true
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        self.initNumberArray()
        self.initTableView()
        
        if Constants.isAccessibilityApplied {
            self.initAccessibility()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initNumberArray() {
        for i in 1..<31 {
            numberArray.append(i)
        }
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self

    }

    func initAccessibility() {
        
        if let header = self.headerView, let table = self.tableView, let footer = self.footerView {
            self.view.accessibilityElements = [header, table, footer]
        }
        
        self.footerButton.accessibilityTraits.insert(.selected)
        self.footerPlusButton.accessibilityTraits.remove(.selected)
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "", message: "지금은 준비중입니다.", preferredStyle: .alert)
        let completeAction = UIAlertAction(title: "확인", style: .default) { action in
        }
        alert.addAction(completeAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ReadjustFocusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadjustFocusTableViewCell", for: indexPath) as! ReadjustFocusTableViewCell
        
        if isPlusMode {
            cell.numberLabel.text = "\(numberArray[indexPath.row] + 30)"
        } else {
            cell.numberLabel.text = "\(numberArray[indexPath.row])"
        }
        
        return cell
    }
    

}
