//
//  NVAccessibilityView.swift
//  NVAccessibilitySolution
//
//  Created by suni on 2021/11/24.
//

import Foundation
import UIKit

// Default values
private let defualtIsAccessibilityFocusStarted: Bool = false

// MARK: UIView
open class NVAccessibilityView: UIView {
    
    // MARK: Public var
    
    // Accessibility Focus
    public var isAccessibilityFocusStarted: Bool = defualtIsAccessibilityFocusStarted
    
    // MARK: Public func
    
    // Accessibility Focus
    public override func accessibilityElementDidBecomeFocused() {
        self.isAccessibilityFocusStarted = true
    }
    
    public override func accessibilityElementDidLoseFocus() {
        self.isAccessibilityFocusStarted = false
    }
}

// MARK: UITableView
open class NVAccessibilityTableView: UITableView {
        
    // Accessibility Focus
    public var isAccessibilityFocusStarted: Bool = defualtIsAccessibilityFocusStarted
    
    // Accessibility Focus
    public override func accessibilityElementDidBecomeFocused() {
        self.isAccessibilityFocusStarted = true
    }
    
    public override func accessibilityElementDidLoseFocus() {
        self.isAccessibilityFocusStarted = false
    }
}

// MARK: UICollectionView
open class NVAccessibilityCollectionView: UICollectionView {
    
    // Accessibility Focus
    public var isAccessibilityFocusStarted: Bool = defualtIsAccessibilityFocusStarted
    
    // Accessibility Focus
    public override func accessibilityElementDidBecomeFocused() {
        self.isAccessibilityFocusStarted = true
    }
    
    public override func accessibilityElementDidLoseFocus() {
        self.isAccessibilityFocusStarted = false
    }
}

// MARK: UICollectionViewCell
open class NVAccessibilityCollectionViewCell: UICollectionViewCell {
    
    // Accessibility Focus
    public var isAccessibilityFocusStarted: Bool = defualtIsAccessibilityFocusStarted
    
    // Accessibility Focus
    public override func accessibilityElementDidBecomeFocused() {
        self.isAccessibilityFocusStarted = true
    }
    
    public override func accessibilityElementDidLoseFocus() {
        self.isAccessibilityFocusStarted = false
    }
}

// MARK: UITableViewCell
open class NVAccessibilityTableViewCell: UITableViewCell {
    
    // Accessibility Focus
    public var isAccessibilityFocusStarted: Bool = defualtIsAccessibilityFocusStarted
    
    // Accessibility Focus
    public override func accessibilityElementDidBecomeFocused() {
        self.isAccessibilityFocusStarted = true
    }
    
    public override func accessibilityElementDidLoseFocus() {
        self.isAccessibilityFocusStarted = false
    }
}

// MARK: UISlider
open class NVAccessibilitySlider: UISlider {
    
    // Accessibility Focus
    public var isAccessibilityFocusStarted: Bool = defualtIsAccessibilityFocusStarted
    
    // Accessibility Focus
    public override func accessibilityElementDidBecomeFocused() {
        self.isAccessibilityFocusStarted = true
    }
    
    public override func accessibilityElementDidLoseFocus() {
        self.isAccessibilityFocusStarted = false
    }
}
