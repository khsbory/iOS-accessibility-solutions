//
//  ReadjustFocusViewController.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/07/27.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReadjustFocusViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        self.isPlusMode = false
        self.tableView.reloadData()
    }
    
    @IBAction func onPlusModeButtonClicked(_ sender: Any) {
        self.isPlusMode = true
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        self.initNumberArray()
        self.initTableView()
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
