//
//  DetailView.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 14/11/2022.
//
import Foundation
import UIKit

class DetailView: UIView {
    
    var backButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = UIColor.orange
        return button
    }()
    
    var favoriteButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
        button.tintColor = UIColor.orange
        return button
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var detailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var detailTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    var detailPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    var detailCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var detailDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    var detailDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    var detailDescriptionContentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        setupViews()
        
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(detailImageView)
        
        scrollView.addSubview(detailTitleLabel)
        scrollView.addSubview(detailPriceLabel)
        scrollView.addSubview(detailCategoryLabel)
        
        scrollView.addSubview(detailDateLabel)
        
        scrollView.addSubview(detailDescriptionLabel)
        scrollView.addSubview(detailDescriptionContentLabel)
        
        addSubview(backButton)
        addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            detailImageView.topAnchor.constraint(equalTo: self.topAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            detailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            detailImageView.heightAnchor.constraint(equalTo: detailImageView.widthAnchor, multiplier: 1.25),
            
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            detailTitleLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 16),
            detailTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            detailTitleLabel.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: -16),
            
            detailPriceLabel.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 8),
            detailPriceLabel.leftAnchor.constraint(equalTo: detailTitleLabel.leftAnchor),
            detailPriceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            detailCategoryLabel.topAnchor.constraint(equalTo: detailPriceLabel.bottomAnchor, constant: 8),
            detailCategoryLabel.leftAnchor.constraint(equalTo: detailTitleLabel.leftAnchor),
            
            detailDateLabel.topAnchor.constraint(equalTo: detailCategoryLabel.bottomAnchor, constant: 8),
            detailDateLabel.leadingAnchor.constraint(equalTo: detailTitleLabel.leadingAnchor),
            
            detailDescriptionLabel.topAnchor.constraint(equalTo: detailDateLabel.bottomAnchor, constant: 16),
            detailDescriptionLabel.leadingAnchor.constraint(equalTo: detailTitleLabel.leadingAnchor),
            
            detailDescriptionContentLabel.topAnchor.constraint(equalTo: detailDescriptionLabel.bottomAnchor, constant: 10),
            detailDescriptionContentLabel.leadingAnchor.constraint(equalTo: detailDescriptionLabel.leadingAnchor),
            detailDescriptionContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
        ])
    }
}
