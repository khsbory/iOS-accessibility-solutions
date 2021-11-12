//
//  DataTableCollectionViewCell.swift
//  IosAccessibilityDemos
//
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class DataTableCalendarCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    var row: Int = 0
    var column: Int = 0
    var rowLength: Int = 0
    var columnLength: Int = 0
}
extension DataTableCalendarCell: UIAccessibilityContainerDataTableCell {
    func accessibilityRowRange() -> NSRange {
        let rowRange: NSRange = NSRange(location: row, length: rowLength)
        return rowRange
    }
    
    func accessibilityColumnRange() -> NSRange {
        let columnRange: NSRange = NSRange(location: column, length: columnLength)
        return columnRange
    }
}
