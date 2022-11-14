//
//  ServiceCategory.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 10/11/2022.
//

import Foundation

public class ServiceCategory: ObservableObject {
    static let shared = ServiceCategory()
    
    public func loadCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data {
                do {
                    let categories = try JSONDecoder().decode([Category].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(categories))
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            }
        }).resume()
    }
}
