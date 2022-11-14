//
//  Category.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 10/11/2022.
//

import Foundation

public class Category: Decodable, Equatable {
    public var id: Int?
    public var name: String?
    
    init(with name: String, id: Int) {
        self.id = id
        self.name = name
    }
    
    public static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
