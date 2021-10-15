//
//  ReloadingTableViewCell.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/10/07.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit
import SkeletonView

class ReloadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filter: ReloadingTableViewFilter?
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
        
        // Configure the view for the selected state
    }
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func initAccessibility() {
        // TableViewCell 안에 CollectionView가 있을 경우, 초점을 하나로 잡는 이슈
        self.accessibilityElements = [self.collectionView]
    }
    
    
    func setNumberArray() {
        array.removeAll()
        
        var  minNumber: Int = filter?.rawValue ?? 0
        minNumber = (minNumber * 50) + 1
        
        for number in minNumber..<minNumber+50 {
            array.append("\(number)")
        }
        
        
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
        // 리로드 할 경우, Skeleton UI를 사용
        self.collectionView.showAnimatedSkeleton()
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.hideSkeleton), userInfo: nil, repeats: false)
    }
    
    @objc func hideSkeleton() {
        self.collectionView.hideSkeleton()
    }
}

extension ReloadingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
