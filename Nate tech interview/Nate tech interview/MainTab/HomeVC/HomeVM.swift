//
//  HomeVM.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class HomeVM {
    private let viewController: Any
    
    init(_ vc: Any) {
        self.viewController = vc
    }
    
    func getProducts() {
        guard let vc = viewController as? HomeVC else { return }
        API.getProducts() { response in
            guard let data = response?.data else { return }
            vc.products = data.products
        }
    }
    
    func filterValues(productName: String, imageStringURLs: [String], merchant: String, createdAt: String, websiteURL: String) {
        guard let cell = viewController as? ProductCell
        else { return }
        
        if productName.count > 0 {
            cell.productName.text = productName
        } else {
            cell.productName.text = "Name is missing.\nWe are looking for it!🤓"
        }
        
        if merchant.count > 0 {
            cell.popUpMerchantLabel.text = "by \(merchant)"
        } else {
            cell.popUpMerchantLabel.text = "by UNKNOWN seller 🧐"
        }
        
        cell.popUpCreatedDateLabel.text = createdAt.substring(to: 10)
        
        if !isValidUrl(urlString: websiteURL) {
            cell.popUpWebsiteButton.isHidden = true
        }
        
        let filteredURLs = imageStringURLs.filter {
            isValidUrl(urlString: $0)
        }
        
        if filteredURLs.count > 0 {
            cell.productImagePVC.imageStringURLs = removeDuplicates(filteredURLs)
        } else {
            cell.productImagePVC.placeHolderImage.isHidden = false
        }
        
        if filteredURLs.count <= 1 {
            cell.productImagePVC.view.subviews.forEach {
                if let scrollView = $0 as? UIScrollView {
                    scrollView.isScrollEnabled = false
                }
            }
        } else {
            cell.productImagePVC.view.subviews.forEach {
                if let scrollView = $0 as? UIScrollView {
                    scrollView.isScrollEnabled = true
                }
            }
        }
        
        cell.webSiteURL = websiteURL
    }
    
    func generatePages() {
        guard let vc = viewController as? ProductImagePVC
        else { return }
        
        vc.pages = vc.imageStringURLs.compactMap {
            ProductImage(urlString: $0)
        }
        vc.setViewControllers([vc.pages[0]], direction: .forward, animated: false)
        vc.pageControl.numberOfPages = vc.pages.count
    }
}
