//
//  ReloadingTableViewCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/10/07.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class ReloadingTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filter: ReloadingTableViewFilter?
    var array: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    
    func setNumberArray() {
        array.removeAll()
        
        if filter == .book {
            for number in 1..<51 {
                print("setNumberArray \(number)")
                array.append("\(number)")
            }
        } else {
            for number in 51..<101 {
                print("setNumberArray \(number)")
                array.append("\(number)")
            }
        }
        
        collectionView.reloadData()
    }

}
extension ReloadingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection \(array.count)")
        return array.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReloadingCollectionViewCell", for: indexPath) as? ReloadingCollectionViewCell else {
            fatalError("Expected a `\(ReloadingCollectionViewCell.self)` but did not receive one.")
        }
        
        cell.numberLabel.text =  array[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (UIScreen.main.bounds.width - 20.0) / 3
        return CGSize(width: width, height: width)
    }
}
