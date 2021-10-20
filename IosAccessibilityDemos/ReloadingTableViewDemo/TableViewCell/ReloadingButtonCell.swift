//
//  ReloadingButtonCell.swift
//  IosAccessibilityDemos
//
//  Created by suni on 2021/10/07.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit
import SkeletonView

public let RELOADING_TIME: TimeInterval = 2.0

class ReloadingButtonCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filter: ReloadingTableViewFilter?
    var delegate: ReloadingTableViewDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
}
extension ReloadingButtonCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
        case 2:
            cell.numberLabel.text = "101~150"
            break
        case 3:
            cell.numberLabel.text = "151~200"
            break
        case 4:
            cell.numberLabel.text = "201~250"
            break
        default:
            cell.numberLabel.text = ""
        }
        
        if indexPath.row == self.filter?.rawValue {
            cell.isSelect = true
        } else {
            cell.isSelect = false
        }
        
        cell.initCell()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let beforeFilter = self.filter
        
        switch indexPath.row {
        case 0:
            self.filter = .oneToFifty
        case 1:
            self.filter = .fifOneToOneHundred
        case 2:
            self.filter = .oHOneToOHFifty
        case 3:
            self.filter = .oHFifOneToTwoHundred
        case 4:
            self.filter = .tHOneToTHFifty
        default:
            self.filter = .oneToFifty
        }
        
        delegate?.selectReloadingFilter(filter: self.filter ?? .oneToFifty)
        
        // 보이스오버가 켜져있을 경우, 주요 CollectionView Cell만 리로드
        let cell = self.collectionView.cellForItem(at: indexPath) as! ReloadingButtonCollectionViewCell
                
        if Constants.isAccessibilityApplied && cell.isVoiceOverRunning {
            let beforeIndexPath = IndexPath(row: beforeFilter?.rawValue ?? 0, section: 0)
            self.collectionView.reloadItems(at: [beforeIndexPath,indexPath])
            
            // 로드 중일 때는, collectionView notEnabled
            self.setNotEnabledCollectionView()

        } else {
            
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            
            // 리로드 할 경우, Skeleton UI를 사용
            self.collectionView.showAnimatedSkeleton()
            
            Timer.scheduledTimer(timeInterval: RELOADING_TIME, target: self, selector: #selector(self.hideSkeleton), userInfo: nil, repeats: false)
        }
    }
    
    
    func setNotEnabledCollectionView() {
        self.collectionView.isUserInteractionEnabled = false
        
        Timer.scheduledTimer(timeInterval: RELOADING_TIME, target: self, selector: #selector(self.setEnabledCollectionView), userInfo: nil, repeats: false)
    }
    
    @objc func hideSkeleton() {
        self.collectionView.hideSkeleton()
    }
    
    @objc func setEnabledCollectionView(){
        self.collectionView.isUserInteractionEnabled = true
    }
}
