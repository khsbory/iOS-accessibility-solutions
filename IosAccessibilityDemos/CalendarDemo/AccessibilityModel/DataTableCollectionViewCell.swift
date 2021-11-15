//
//  DataTableCollectionViewCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/11/15.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

/**
 # (C) DataTableCollectionViewCell
 - Note:접근성이 적용된 DataTable CollectionViewCell
*/
class DataTableCollectionViewCell: UICollectionViewCell {
    
    var row: Int = 0
    var column: Int = 0
    var rowLength: Int = 0
    var columnLength: Int = 0
    
    
}

extension DataTableCollectionViewCell: UIAccessibilityContainerDataTableCell {
    func accessibilityRowRange() -> NSRange {
        let rowRange: NSRange = NSRange(location: row, length: rowLength)
        return rowRange
    }
    
    func accessibilityColumnRange() -> NSRange {
        let columnRange: NSRange = NSRange(location: column, length: columnLength)
        return columnRange
    }
}
