//
//  DataTableCollectionView.swift
//  IosAccessibilityDemos
//
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

/**
 # (C) DataTableCollectionView
 - Note:접근성이 적용된 DataTable Type CollectionView
*/
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
    
    // column의 header 지정
    func accessibilityHeaderElements(forColumn column: Int) -> [UIAccessibilityContainerDataTableCell]? {

        if column >= 0 && column < columnCount {
            return [headerCells[column]]
        } else {
            return nil
        }
        
    }
    
    // row의 header 지정
//    func accessibilityHeaderElements(forRow row: Int) -> [UIAccessibilityContainerDataTableCell]? {
//
//        if row >= 0 && row < columnCount {
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
