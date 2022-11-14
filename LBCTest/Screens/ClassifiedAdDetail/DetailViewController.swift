//
//  DetailViewController.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 14/11/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView: DetailView?

    var coordinator: CoordinatorApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupDetailView()
        setupDetailContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        detailView!.scrollView.contentSize = CGSize(width: view.frame.width, height: detailView!.detailDescriptionContentLabel.frame.origin.y + detailView!.detailDescriptionContentLabel.frame.height)
    }
                                              
    func setupDetailView() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        detailView = DetailView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
                
        view.addSubview(detailView!)
        
        detailView?.backButton.addTarget(self, action: #selector(backToPreviousPage), for: .touchUpInside)
    }
    
    func setupDetailContent() {
        if let productDetail = coordinator?.productDetail {
            detailView?.detailImageView.downloaded(from: productDetail.images?.thumb ?? "", contentMode: .scaleAspectFit)
            detailView?.detailTitleLabel.text = productDetail.title
            detailView?.detailPriceLabel.text = String(Int(productDetail.price ?? 0.0)) + " €"
            detailView?.detailDateLabel.text = Date().convertStringToDate(fromDate: productDetail.creationDate ?? "").displayDateFormat()
            detailView?.detailDescriptionContentLabel.text = productDetail.description
        }
    }
    
    @objc func backToPreviousPage() {
        coordinator?.previous()
    }

}
