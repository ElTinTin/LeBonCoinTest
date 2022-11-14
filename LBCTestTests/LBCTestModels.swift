//
//  LBCTestTests.swift
//  LBCTestTests
//
//  Created by Quentin Deschamps on 10/11/2022.
//

import XCTest
@testable import LBCTest

final class LBCTestModels: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCategoryInit() throws {
        let category = Category(with: "Voiture", id: 1)
        
        XCTAssertEqual(category.name, "Voiture")
        XCTAssertEqual(category.id, 1)
    }
    
    func testClassifiedAdInit() throws {
        let imageURLs = ImageURLs(small: "small.jpg", thumb: "thumb.jpg")
        let classifiedAd = ClassifiedAd(id: 1212, categoryId: 1, title: "Aston Martin DB5", description: "Voiture de collection, mythique de James Bond", price: 999999.99, images: imageURLs, creationDate: "22.08.2022", isUrgent: true)
        
        XCTAssertEqual(classifiedAd.id, 1212)
        XCTAssertEqual(classifiedAd.categoryId, 1)
        XCTAssertEqual(classifiedAd.title, "Aston Martin DB5")
        XCTAssertEqual(classifiedAd.description, "Voiture de collection, mythique de James Bond")
        XCTAssertEqual(classifiedAd.price, 999999.99)
        XCTAssertEqual(imageURLs.small, "small.jpg")
        XCTAssertEqual(imageURLs.thumb, "thumb.jpg")
        XCTAssertEqual(classifiedAd.images?.small, imageURLs.small)
        XCTAssertEqual(classifiedAd.images?.thumb, imageURLs.thumb)
        XCTAssertEqual(classifiedAd.creationDate, "22.08.2022")
        XCTAssertEqual(classifiedAd.isUrgent, true)
    }
    
    func testLoadCategories() throws {
        var categoryLoaded = Category(with: "", id: 0)
        let categoryTest = Category(with: "Véhicule", id: 1)
        
        ServiceCategory.shared.loadCategories(completion: { result in
            switch result {
            case .success(let categories):
                categoryLoaded = categories.first!
                XCTAssertEqual(categoryLoaded.name, categoryTest.name)
                XCTAssertEqual(categoryLoaded.id, categoryTest.id)
            case .failure(_):
                break
            }
        })
        
    }
    
    func testLoadClassifiedAd() throws {
        let classifiedAdTest = ClassifiedAd(id: 1461267313, categoryId: 4, title: "Statue homme noir assis en plâtre polychrome", description: "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible", price: 140.00, images: ImageURLs(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"), creationDate: "2019-11-05T15:56:59+0000", isUrgent: false)
        var classifiedAdLoad = ClassifiedAd(id: 0, categoryId: 0, title: "", description: "", price: 0.0, images: ImageURLs(small: "", thumb: ""), creationDate: "", isUrgent: false)
        
        ServiceClassifiedAds.shared.loadClassifiedAds(completion: { result in
            switch result {
            case .success(let classifiedAds):
                classifiedAdLoad = classifiedAds.first!
                XCTAssertEqual(classifiedAdLoad.id, classifiedAdTest.id)
                XCTAssertEqual(classifiedAdLoad.title, classifiedAdTest.title)
            case .failure(_):
                break
            }
        })
    }
}
