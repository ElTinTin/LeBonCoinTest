//
//  CollectionHeaderViewCell.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//

import Foundation
import UIKit

class CollectionHeaderViewCell: UICollectionReusableView {
    
    static let cellIdentifier = "CollectionHeaderViewCell"
    
    var numberOfResultLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(numberOfResultLabel)

        NSLayoutConstraint.activate([
            
            numberOfResultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            numberOfResultLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

