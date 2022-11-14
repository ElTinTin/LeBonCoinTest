//
//  LBCTestViewModels.swift
//  LBCTestTests
//
//  Created by Quentin Deschamps on 14/11/2022.
//

import XCTest
@testable import LBCTest

final class LBCTestViewModels: XCTestCase {
    
    var classifiedAdsViewModel: ClassifiedAdsViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        classifiedAdsViewModel = ClassifiedAdsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProductViewModel() {
        let oneAd: ClassifiedAd = ClassifiedAd(id: 0123456, categoryId: 1, title: "oneAd", description: "descOneAd", price: 10.0, images: ImageURLs(small: "small.jpg", thumb: "thumb.jpg"), creationDate: "2022-11-13T17:17:40+0000", isUrgent: false)
        let anotherAd: ClassifiedAd = ClassifiedAd(id: 6543210, categoryId: 3, title: "anotherAd", description: "descAnotherAd", price: 3000.0, images: ImageURLs(small: "small.jpg", thumb: "thumb.jpg"), creationDate: "2022-11-12T08:32:32+0000", isUrgent: true)
        let againAnotherAd: ClassifiedAd = ClassifiedAd(id: 0987654, categoryId: 4, title: "againAnotherAd", description: "descAgainAnotherAd", price: 20.0, images: ImageURLs(small: "small.jpg", thumb: "thumb.jpg"), creationDate: "2022-11-11T08:32:32+0000", isUrgent: true)
        
        classifiedAdsViewModel?.listOfClassifiedAds.append(oneAd)
        classifiedAdsViewModel?.listOfClassifiedAds.append(anotherAd)
        classifiedAdsViewModel?.listOfClassifiedAds.append(againAnotherAd)
        
        XCTAssertEqual(3, classifiedAdsViewModel?.listOfClassifiedAds.count)
        
        let category = Category(with: "Objets", id: 1)
        classifiedAdsViewModel?.listOfCategories.append(category)
        
        classifiedAdsViewModel?.sortListOfAdsByDate(completion: {
            if let firstAd = classifiedAdsViewModel?.listOfClassifiedAds.first, let lastAd = classifiedAdsViewModel?.listOfClassifiedAds.last {
                // firstAd is againAnotherAd 11/11/2022 but Urgent, lastAd is oneAd 13/11/2022 but not Urgent
                XCTAssert(firstAd.creationDateTime < lastAd.creationDateTime)
                XCTAssertEqual(firstAd.isUrgent, true)
                XCTAssertEqual(lastAd.isUrgent, false)
            }
        })
        XCTAssertEqual("Objets", classifiedAdsViewModel?.searchCategory(categoryId: oneAd.categoryId ?? 0))
    }
}
