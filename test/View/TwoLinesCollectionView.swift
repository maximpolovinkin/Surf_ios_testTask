//
//  TwoLinesCollectionView.swift
//  test
//
//  Created by Максим Половинкин on 07.02.2023.
//

import Foundation
import UIKit

class TwoLinesCollectionView: UICollectionView {
    private let namesLayout = UICollectionViewFlowLayout()
    private var names =  DataManager().obtainData()
   
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: namesLayout)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// setup views
    private func setView() {
        namesLayout.minimumInteritemSpacing = 12
        namesLayout.scrollDirection = .horizontal
        alpha = 0.0
        
        
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        bounces = false
        showsHorizontalScrollIndicator = false

        delegate = self
        dataSource = self
    
        register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}


extension TwoLinesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            cell.courseName.text = names[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    //MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            return false
        }
        return true
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nameFont = UIFont(name: "Arial Bold", size: 14)
        let nameAttributes = [NSAttributedString.Key.font : nameFont as Any]
        let nameWidth = names[indexPath.item].size(withAttributes: nameAttributes).width + 48
        
        return CGSize(width: nameWidth, height: 44)
    }
}
