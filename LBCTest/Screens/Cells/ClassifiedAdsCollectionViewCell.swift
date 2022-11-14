//
//  ClassifiedAdsCollectionViewCell.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//

import Foundation
import UIKit

class ClassifiedAdsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ClassifiedAdsCollectionViewCell"
    
    var productCardView: CardView = {
        var view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func layoutSubviews() {
        
        addSubview(productCardView)
        
        NSLayoutConstraint.activate([
            productCardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            productCardView.widthAnchor.constraint(equalTo: self.widthAnchor),
            productCardView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
}

