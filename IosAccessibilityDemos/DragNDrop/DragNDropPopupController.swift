//
//  PopupController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/02/05.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class DragNDropPopupController: UIViewController {
    
    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    var popupDelegate: DragNDropPopupDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        initAccessibility()
        
    }
    
    @IBAction func onCloseButtonClicked(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        popupDelegate?.onPopupClosed()
    }
    
    private func initAccessibility() {
        if (Constants.isAccessibilityApplied) {
            //accessibilityLabel만 지정하면 안되고 isAccessibilityElement = true도 같이 선언해야 하는 듯 
            popupImage.isAccessibilityElement = true
            popupImage.accessibilityLabel = "드래그 & 드롭 기능을 체험해 보세요"
        }
    }
}
