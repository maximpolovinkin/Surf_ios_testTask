//
//  CollectionViewCell.swift
//  test
//
//  Created by Максим Половинкин on 06.02.2023.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
     //MARK: - init and UI elements
    let courseName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor =  #colorLiteral(red: 0.1921568811, green: 0.1921568811, blue: 0.1921568811, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? #colorLiteral(red: 0.1921568811, green: 0.1921568811, blue: 0.1921568811, alpha: 1) : #colorLiteral(red: 0.9529410005, green: 0.9529414773, blue: 0.9615502954, alpha: 1)
            courseName.textColor =  self.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1921568811, green: 0.1921568811, blue: 0.1921568811, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    /// setup views
    private func setUpViews(){
        backgroundColor =  #colorLiteral(red: 0.9529410005, green: 0.9529414773, blue: 0.9615502954, alpha: 1)
        layer.cornerRadius = 12
        addSubview(courseName)
    }
    
    /// set constraints
    private func setConstraints(){
        NSLayoutConstraint.activate([
            courseName.centerXAnchor.constraint(equalTo: centerXAnchor),
            courseName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
