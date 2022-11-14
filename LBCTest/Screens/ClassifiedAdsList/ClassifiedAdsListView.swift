//
//  ClassifiedAdsListView.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//
import Foundation
import UIKit

class ClassifiedAdsListView: UIView {
    
    var viewTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    var categoriesCollectionView: UICollectionView = {
        var collectionFlow: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionFlow.minimumInteritemSpacing = 8
        collectionFlow.scrollDirection = .horizontal
        
        collectionFlow.minimumLineSpacing = 0
        var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlow)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.tag = 1
        
        return collectionView
    }()
    
    var collectionView: UICollectionView = {
        var collectionFlow: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionFlow.minimumInteritemSpacing = 8
        collectionFlow.scrollDirection = .vertical
        
        collectionFlow.minimumLineSpacing = 0
        var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlow)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.tag = 2
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(viewTitleLabel)
        addSubview(categoriesCollectionView)
        addSubview(collectionView)
                
        NSLayoutConstraint.activate([
            viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            viewTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            viewTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: self.viewTitleLabel.bottomAnchor, constant: 10),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

