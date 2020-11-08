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
        API.getProducts() { [weak self] response in
            guard let strongSelf = self,
                  let data = response?.data,
                  let vc = strongSelf.viewController as? HomeVC
            else { return }
            vc.products = data.products
        }
    }
    
    func filterValues(title: String, imageStringURLs: [String], merchant: String, createdAt: String, websiteURL: String) {
        guard let vc = viewController as? ProductCell
        else { return }
        
        if title.count > 0 {
            vc.titleLabel.text = title
        } else {
            vc.titleLabel.text = "Name is missing.\nWe are looking for it!🤓"
        }
        
        if merchant.count > 0 {
            vc.popUpMerchantLabel.text = "by \(merchant)"
        } else {
            vc.popUpMerchantLabel.text = "by UNKNOWN seller 🧐"
        }
        
        vc.popUpCreatedDateLabel.text = createdAt.substring(to: 10)
        
        if !isValidUrl(urlString: websiteURL) {
            vc.popUpWebsiteButton.isHidden = true
        }
        
        let filteredURLs = imageStringURLs.filter {
            isValidUrl(urlString: $0)
        }
        
        if filteredURLs.count > 0 {
            vc.productImagePVC.imageStringURLs = removeDuplicates(filteredURLs)
        } else {
            vc.productImagePVC.placeHolderImage.isHidden = false
        }
        
        if filteredURLs.count <= 1 {
            vc.productImagePVC.view.subviews.forEach {
                if let scrollView = $0 as? UIScrollView {
                    scrollView.isScrollEnabled = false
                }
            }
        } else {
            vc.productImagePVC.view.subviews.forEach {
                if let scrollView = $0 as? UIScrollView {
                    scrollView.isScrollEnabled = true
                }
            }
        }
        
        vc.webSiteURL = websiteURL
    }
    
    func isValidUrl (urlString: String?) -> Bool {
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else { return false }
        
        return UIApplication.shared.canOpenURL(url)
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
    
    func removeDuplicates(_ array: [String]) -> [String] {
        var result = [String]()
        var temp = [String]()

        for element in array {
            let url = element.replacingOccurrences(of: "http://", with: "")
                      .replacingOccurrences(of: "https://", with: "")
            if temp.contains(url) == false {
                result.append(element)
                temp.append(url)
            }
        }

        return result
    }
}
