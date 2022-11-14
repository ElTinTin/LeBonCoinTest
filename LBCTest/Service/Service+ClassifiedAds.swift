//
//  Service+ClassifiedAds.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 10/11/2022.
//

import Foundation

public class ServiceClassifiedAds: ObservableObject {
    static let shared = ServiceClassifiedAds()
    
    public func loadClassifiedAds(completion: @escaping (Result<[ClassifiedAd], NetworkError>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data {
                do {
                    let classifiedAds = try JSONDecoder().decode([ClassifiedAd].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(classifiedAds))
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
