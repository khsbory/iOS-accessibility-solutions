//
//  DataTableCollectionView.swift
//  IosAccessibilityDemos
//
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class DataTableCollectionView: UICollectionView {
    
    var headerCells: [UIAccessibilityContainerDataTableCell] = []
    var headerCellCount: Int = 0
    
    var rowCount: Int = 0
    var columnCount: Int = 0
    
    var isRowReaderOn: Bool = false
    var isColumnReaderOn: Bool = false
    
    func initDataTable() {
        self.accessibilityContainerType = .dataTable
    }
}
extension DataTableCollectionView: UIAccessibilityContainerDataTable {
    
    func accessibilityHeaderElements(forColumn column: Int) -> [UIAccessibilityContainerDataTableCell]? {

        if column >= 0 && column < columnCount {
            print("accessibilityHeaderElements  column \(column)")
            print("\(headerCells[column])")
            return [headerCells[column]]
            
        } else {
            return nil
        }
    }
    
//    func accessibilityHeaderElements(forRow row: Int) -> [UIAccessibilityContainerDataTableCell]? {
//        if row >= 0 && row < columnCount {
//            print("accessibilityHeaderElements  row \(row)")
//            return [headerCells[row]]
//        } else {
//            return nil
//        }
//
//    }
    
    func accessibilityDataTableCellElement(forRow row: Int, column: Int) -> UIAccessibilityContainerDataTableCell? {
        return nil
    }
    
    func accessibilityRowCount() -> Int {
        return self.isRowReaderOn ? rowCount : 0
    }
    
    func accessibilityColumnCount() -> Int {
        return self.isColumnReaderOn ? columnCount : 0
    }
    
    
}
