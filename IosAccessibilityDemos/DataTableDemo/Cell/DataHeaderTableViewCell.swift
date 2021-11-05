//
//  DataHeaderTableViewCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/11/03.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class DataHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var array: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initCollectionView()
        
        if Constants.isAccessibilityApplied {
            self.initAccessibility()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func initCollectionView() {
        print("initCollectionView \(array)")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func initAccessibility() {
        // TableViewCell 안에 CollectionView가 있을 경우, 초점을 하나로 잡는 이슈
        self.accessibilityElements = [self.collectionView]
    }
    
    func setArrayData(array: [String]) {
        print("setArrayData \(array)")
        self.array = array
        self.collectionView.reloadData()
    }
}

extension DataHeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataHeaderCollectionViewCell", for: indexPath) as? DataHeaderCollectionViewCell else {
            fatalError("Expected a `\(DataHeaderCollectionViewCell.self)` but did not receive one.")
        }
        
        cell.label.text =  array[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  UIScreen.main.bounds.width  / (CGFloat(array.count))
        print("collectionViewLayout \(width)")
        return CGSize(width: width, height: width / 2)
    }
}
