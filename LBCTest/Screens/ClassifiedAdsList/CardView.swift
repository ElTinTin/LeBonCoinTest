//
//  CardView.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//

import Foundation
import UIKit

class CardView: UIView {
    
    var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var categoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var isUrgentView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.orange.withAlphaComponent(0.15)
        view.isHidden = true
        return view
    }()
    
    var isUrgentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vente urgente"
        label.textColor = .orange
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return label
    }()

    override func layoutSubviews() {
        
        setupViews()
        
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(categoryLabel)
        
        addSubview(isUrgentView)
        isUrgentView.addSubview(isUrgentLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.1),
            
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            priceLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            categoryLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            
            isUrgentView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            isUrgentView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            isUrgentView.heightAnchor.constraint(equalToConstant: 24),
            
            isUrgentLabel.leftAnchor.constraint(equalTo: isUrgentView.leftAnchor, constant: 8),
            isUrgentLabel.rightAnchor.constraint(equalTo: isUrgentView.rightAnchor, constant: -8),
            isUrgentLabel.centerYAnchor.constraint(equalTo: isUrgentView.centerYAnchor),
        ])
    }

}


