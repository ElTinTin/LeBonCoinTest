//
//  ClassifiedAd.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 10/11/2022.
//

import Foundation

public class ClassifiedAd: Decodable {
    public var id: Int?
    public var categoryId: Int?
    public var title: String?
    public var description: String?
    public var price: Float?
    public var images: ImageURLs?
    public var creationDate: String?
    public var isUrgent: Bool?
    
    public var creationDateTime: TimeInterval = TimeInterval()
    
    init(id: Int, categoryId: Int, title: String, description: String, price: Float, images: ImageURLs, creationDate: String, isUrgent: Bool) {
        self.id = id
        self.categoryId = categoryId
        self.title = title
        self.description = description
        self.price = price
        self.images = images
        self.creationDate = creationDate
        self.isUrgent = isUrgent
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case images = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}

public class ImageURLs: Decodable {
    public var small: String?
    public var thumb: String?
    
    init(small: String, thumb: String) {
        self.small = small
        self.thumb = thumb
    }
}
