//
//  ClassifiedAdsViewModel.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//

import Foundation

protocol ClassifiedAdsViewModelProtocol {
    
    var listOfClassifiedAds: [ClassifiedAd] { get set }
    
    var isFiltered: Bool { get set }
    
    var listOfFilteredClassifiedAds: [ClassifiedAd] { get set }
    
    var listOfCategories: [Category] { get set }
    
    var listOfSelectedCategories: [Category] { get set }
    
    func searchCategory(categoryId: Int) -> String
    
    func sortListOfAdsByDate(completion: (() -> ()))
    
    func filterListOfProductsBySelectedCategories(completion: (() -> ()))
}

class ClassifiedAdsViewModel: ClassifiedAdsViewModelProtocol {
    
    var listOfClassifiedAds: [ClassifiedAd] = []
    
    var isFiltered: Bool = false
    
    var listOfFilteredClassifiedAds: [ClassifiedAd] = []
    
    var listOfCategories: [Category] = []
    
    var listOfSelectedCategories: [Category] = []
    
    init() {
    }
    
    func searchCategory(categoryId: Int) -> String {
        if listOfCategories.isEmpty {
            return ""
        }
        for category in listOfCategories {
            if category.id ?? 0 == categoryId {
                return category.name ?? ""
            }
        }
        return ""
    }
    
    func sortListOfAdsByDate(completion: (() -> ())) {
        if listOfClassifiedAds.isEmpty {
            return
        }
        
        var productDatetime: TimeInterval = 0
        for index in listOfClassifiedAds.indices {
            productDatetime = Date().convertStringToDate(fromDate: listOfClassifiedAds[index].creationDate ?? "").timeIntervalSince1970
            listOfClassifiedAds[index].creationDateTime = productDatetime
        }
        
        listOfClassifiedAds.sort(by: {
            $0.creationDateTime > $1.creationDateTime
        })
        
        listOfClassifiedAds.sort(by: {
            ($0.isUrgent ?? false) && !($1.isUrgent ?? false)
        })
        completion()
    }
    
    func filterListOfProductsBySelectedCategories(completion: (() -> ())) {
        listOfFilteredClassifiedAds.removeAll()
        if listOfSelectedCategories.isEmpty {
            completion()
        }
        var filteredListOfClassifiedAds: [ClassifiedAd] = []
        var productIsInCategory: Bool = false
        let listOfSelectedCategoriesId = listOfSelectedCategories.map { $0.id }
    
        for ad in listOfClassifiedAds {
            productIsInCategory = false
            if listOfSelectedCategoriesId.contains(ad.categoryId) {
                productIsInCategory = true
            }
            if productIsInCategory == true {
                filteredListOfClassifiedAds.append(ad)
            }
        }

        listOfFilteredClassifiedAds = filteredListOfClassifiedAds
        completion()
    }
}
