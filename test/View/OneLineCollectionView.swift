//
//  CollectionView.swift
//  test
//
//  Created by Максим Половинкин on 06.02.2023.
//

import UIKit

class OneLineCollectionView: UICollectionView {
    private let namesLayout = UICollectionViewFlowLayout()
    private var names =  DataManager().obtainData()
    private var nameToShift = ""
    
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
        
        
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        bounces = false
        showsHorizontalScrollIndicator = false
        
        delegate = self
        dataSource = self
    
        
        register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}


extension OneLineCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nameToShift = names[indexPath.item]
        names.remove(at: indexPath.item)
        names.insert(nameToShift, at: 0)
        
        collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: 0))
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
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
