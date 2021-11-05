//
//  DataTableViewCell.swift
//  IosAccessibilityDemos
//
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var array: [String] = []
    
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
    
    func setArrayData(data: TableData) {
        self.array.removeAll()
        self.array.append(data.name)
        self.array.append(data.kor)
        self.array.append(data.eng)
        self.array.append(data.math)
        self.collectionView.reloadData()
    }

}


extension DataTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection \(array.count)")
        return array.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataTableCollectionViewCell", for: indexPath) as? DataTableCollectionViewCell else {
            fatalError("Expected a `\(DataTableCollectionViewCell.self)` but did not receive one.")
        }
        print("cellForItemAt \(array) \(indexPath.row)")
        cell.label.text =  array[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  UIScreen.main.bounds.width / (CGFloat(array.count))
        return CGSize(width: width, height: width)
    }
}
