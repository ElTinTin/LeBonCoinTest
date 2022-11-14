//
//  CategoryCollectionViewCell.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//

import Foundation
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CategoryCollectionViewCell"
    
    var categoryView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.75
        return view
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override func layoutSubviews() {
        
        addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            categoryView.heightAnchor.constraint(equalToConstant: 30),
            
            categoryLabel.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor, constant: 15),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: -15),
        ])
    }
}

