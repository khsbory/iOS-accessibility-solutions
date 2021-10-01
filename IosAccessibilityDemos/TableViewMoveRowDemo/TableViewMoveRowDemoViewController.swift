//
//  TableViewMoveRowDemoViewController.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/10/01.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class TableViewMoveRowDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var numberArray: Array<Int> = [1,2,3,4,5]
    
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
        
        
        // Drag & Drop 기능을 위한 부분
        self.tableView.dragInteractionEnabled = true
        self.tableView.dragDelegate = self
        self.tableView.dropDelegate = self
        
    }
    

}
// MARK:- UITableView UITableViewDelegate, UITableViewDataSource
extension TableViewMoveRowDemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewMoveRowDemoCell", for: indexPath) as! TableViewMoveRowDemoCell
        
        let number = numberArray[indexPath.row]
        
        cell.numberLabel.text = "\(number)"
        
        
        return cell
    }
    
    // Row Editable true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Move Row Instance Method
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = self.numberArray[sourceIndexPath.row]
        self.numberArray.remove(at: sourceIndexPath.row)
        self.numberArray.insert(moveCell, at: destinationIndexPath.row)
    }
    
}
// MARK:- UITableView UITableViewDragDelegate
extension TableViewMoveRowDemoViewController: UITableViewDragDelegate {
func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}
 
// MARK:- UITableView UITableViewDropDelegate
extension TableViewMoveRowDemoViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
}
