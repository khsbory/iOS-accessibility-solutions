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
    
    var filter: ReloadingTableViewFilter?
    var delegate: ReloadingTableViewDelegate?
    
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
        
        
        switch indexPath.row {
        case 0:
            cell.numberLabel.text = "1~50"
            break
        case 1:
            cell.numberLabel.text = "51~100"
            break
        default:
            cell.numberLabel.text = ""
        }
        
        if indexPath.row == self.filter?.rawValue {
            cell.isSelected = true
            cell.backgroundColor = .gray
        } else {
            cell.isSelected = false
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.filter = .book
        case 1:
            self.filter = .movie
        default:
            self.filter = .book
        }
        
        delegate?.selectReloadingFilter(filter: self.filter ?? .book)
        self.collectionView.reloadData()
    }
}
