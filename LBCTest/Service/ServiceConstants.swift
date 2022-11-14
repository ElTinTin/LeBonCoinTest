//
//  ServiceConstants.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 10/11/2022.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

public enum NetworkSuccess {
    case success
}
