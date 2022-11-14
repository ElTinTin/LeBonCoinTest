//
//  ClassifiedAdsListViewController.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 10/11/2022.

import UIKit

class ClassifiedAdsListViewController: UIViewController {
    
    var productListView: ClassifiedAdsListView?
    
    var coordinator: CoordinatorApp?
    
    var classifiedAdsViewModel: ClassifiedAdsViewModel?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupDashboardView()
        
        classifiedAdsViewModel = ClassifiedAdsViewModel()
        
        if classifiedAdsViewModel!.listOfClassifiedAds.isEmpty {
            fetchProductsListRequest()
        }
        
        if classifiedAdsViewModel!.listOfCategories.isEmpty {
            fetchProductCategoryRequest()
        }
    }
    
    func setupDashboardView() {
        productListView = ClassifiedAdsListView()
        
        productListView?.frame = view.bounds
        productListView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                
        view.addSubview(productListView!)
        
        productListView?.viewTitleLabel.text = "Mes Petites Annonces"
        
        setupProductsCollectionView()
    }
    
    func setupProductsCollectionView() {
        productListView?.collectionView.delegate = self
        productListView?.collectionView.dataSource = self
        productListView?.collectionView.register(ClassifiedAdsCollectionViewCell.self, forCellWithReuseIdentifier: ClassifiedAdsCollectionViewCell.cellIdentifier)
        
        productListView?.collectionView.register(CollectionHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderViewCell.cellIdentifier)
        
        productListView?.categoriesCollectionView.delegate = self
        productListView?.categoriesCollectionView.dataSource = self
        productListView?.categoriesCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.cellIdentifier)
    }
}

// MARK: Funcs for Fetching Data
extension ClassifiedAdsListViewController {
    func fetchProductsListRequest() {
        ServiceClassifiedAds.shared.loadClassifiedAds(completion: { result in
            switch result {
            case .success(let classifiedAds):
                self.classifiedAdsViewModel?.listOfClassifiedAds = classifiedAds
                self.classifiedAdsViewModel?.sortListOfAdsByDate(completion: {
                    self.productListView?.collectionView.reloadData()
                })
            case .failure(_):
                break
            }
        })
    }
    
    func fetchProductCategoryRequest() {
        
        ServiceCategory.shared.loadCategories(completion: { result in
            switch result {
            case .success(let categories):
                self.classifiedAdsViewModel?.listOfCategories = categories
                self.classifiedAdsViewModel?.listOfSelectedCategories.removeAll()
                self.productListView?.categoriesCollectionView.reloadData()
            case .failure(_):
                break
            }
        })
    }
}

// MARK: Collection View Delegate
extension ClassifiedAdsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return classifiedAdsViewModel?.listOfCategories.count ?? 0
        }
        if let listOfSelectedCategories = classifiedAdsViewModel?.listOfSelectedCategories {
            classifiedAdsViewModel?.isFiltered = false
            if !listOfSelectedCategories.isEmpty {
                classifiedAdsViewModel?.isFiltered = true
                return classifiedAdsViewModel?.listOfFilteredClassifiedAds.count ?? 0
            }
        }
        return classifiedAdsViewModel?.listOfClassifiedAds.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
            guard let category = classifiedAdsViewModel?.listOfCategories[indexPath.row] else { return CategoryCollectionViewCell(frame: .zero) }
            
            if let contain = classifiedAdsViewModel?.listOfSelectedCategories.contains(category), contain {
                cell.categoryView.layer.borderColor = UIColor.orange.cgColor
                cell.categoryView.layer.borderWidth = 2
                cell.categoryView.layer.backgroundColor = UIColor.orange.cgColor.copy(alpha: 0.15)
                cell.categoryLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                cell.categoryLabel.textColor = UIColor.orange
            } else {
                cell.categoryView.layer.borderColor = UIColor.orange.cgColor
                cell.categoryView.layer.borderWidth = 0.75
                cell.categoryView.layer.backgroundColor = UIColor.white.cgColor
                cell.categoryLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                cell.categoryLabel.textColor = UIColor.orange
            }
            
            cell.categoryLabel.text = category.name
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifiedAdsCollectionViewCell.cellIdentifier, for: indexPath) as! ClassifiedAdsCollectionViewCell
            
            let product: ClassifiedAd
            if classifiedAdsViewModel!.isFiltered {
                product = classifiedAdsViewModel!.listOfFilteredClassifiedAds[indexPath.row]
            } else {
                product = classifiedAdsViewModel!.listOfClassifiedAds[indexPath.row]
            }
            
            let widthPerItem = collectionView.frame.width / 2
            let imageAddress: String?
            
            if widthPerItem > 300 {
                imageAddress = product.images?.thumb
            } else {
                imageAddress = product.images?.small
            }
            cell.productCardView.imageView.downloaded(from: imageAddress ?? "")
            cell.productCardView.titleLabel.text = product.title
            cell.productCardView.priceLabel.text = String(Int(product.price ?? 0.0)) + " €"
            cell.productCardView.categoryLabel.text = classifiedAdsViewModel!.searchCategory(categoryId: product.categoryId ?? 0)
            if product.isUrgent ?? false {
                cell.productCardView.isUrgentView.isHidden = false
            } else {
                cell.productCardView.isUrgentView.isHidden = true
            }
            return cell
        }
    }
    
    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            let calculatedSize = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            calculatedSize.text = classifiedAdsViewModel?.listOfCategories[indexPath.row].name

            calculatedSize.font = UIFont.systemFont(ofSize: 14, weight: .regular)

            calculatedSize.sizeToFit()
            
            return CGSize(width: (calculatedSize.bounds.width + 28), height: 50)
        } else {
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
            return CGSize(width: widthPerItem, height: widthPerItem * 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            guard let selectedCategory = classifiedAdsViewModel?.listOfCategories[indexPath.row] else { return }
            
            if let contain = classifiedAdsViewModel?.listOfSelectedCategories.contains(selectedCategory), contain {
                classifiedAdsViewModel?.listOfSelectedCategories = (classifiedAdsViewModel?.listOfSelectedCategories.filter { $0 !== selectedCategory })!
            } else {
                classifiedAdsViewModel?.listOfSelectedCategories.append(selectedCategory)
            }
            
            classifiedAdsViewModel?.filterListOfProductsBySelectedCategories(completion: {
                productListView?.collectionView.reloadData()
                productListView?.categoriesCollectionView.reloadData()
            })
        } else {
            if classifiedAdsViewModel!.isFiltered {
                coordinator?.productDetail = classifiedAdsViewModel?.listOfFilteredClassifiedAds[indexPath.row]
            } else {
                coordinator?.productDetail = classifiedAdsViewModel?.listOfClassifiedAds[indexPath.row]
            }
            coordinator?.navigateToDetail()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag != 1 {
            switch kind {
                case UICollectionView.elementKindSectionHeader:
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderViewCell.cellIdentifier, for: indexPath)
                    headerView.frame.size.height = 22
                    headerView.frame.size.width = collectionView.frame.width
                    guard let typedHeaderView = headerView as? CollectionHeaderViewCell else {
                        return headerView
                    }
                    let numberOfResult: Int
                    if classifiedAdsViewModel!.isFiltered {
                        numberOfResult = classifiedAdsViewModel!.listOfFilteredClassifiedAds.count
                    } else {
                        numberOfResult = classifiedAdsViewModel!.listOfClassifiedAds.count
                    }
                    typedHeaderView.numberOfResultLabel.text = String(numberOfResult) + " annonces"
                
                    return typedHeaderView
                case UICollectionView.elementKindSectionFooter:
                    return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                default:
                    return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            }
        }
        return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 0, height: 0)
        }
        
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
}



