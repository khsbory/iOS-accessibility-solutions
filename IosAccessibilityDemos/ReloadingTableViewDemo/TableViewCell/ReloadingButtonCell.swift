//
//  ReloadingButtonCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/10/07.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReloadingButtonCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let array = ["1~50","51~100"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.initCollectionView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
extension ReloadingButtonCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReloadingButtonCollectionViewCell", for: indexPath) as? ReloadingButtonCollectionViewCell else {
            fatalError("Expected a `\(ReloadingButtonCollectionViewCell.self)` but did not receive one.")
        }
        
        cell.numberLabel.text =  array[indexPath.row]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}
