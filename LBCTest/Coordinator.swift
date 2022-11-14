//
//  Coordinator.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) -> Void {
        self.childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) -> Void {
        childCoordinators = childCoordinators.filter({ $0 !== coordinator })
    }
}

class CoordinatorApp: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var productDetail: ClassifiedAd?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let productListVC = ClassifiedAdsListViewController()
        productListVC.coordinator = self
        self.navigationController.pushViewController(productListVC, animated: false)
    }
    
    func navigateToDetail() {
        let detailVC = DetailViewController()
        detailVC.coordinator = self
        self.navigationController.pushViewController(detailVC, animated: true)
    }
    
    func previous() {
        self.navigationController.viewDidLoad()
        self.navigationController.popViewController(animated: true)
    }
}


