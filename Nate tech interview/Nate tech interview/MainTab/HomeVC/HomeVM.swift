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
    
    func showPVC() {
        guard let vc = viewController as? ProductCell
        else { return }
        let filteredURLs = vc.imageStringURLs.filter{ isValidUrl(urlString: $0) }
        if filteredURLs.count > 0 {
            vc.productImagePVC.imageStringURLs = filteredURLs
            vc.productImagePVC.placeHolderImage.isHidden = true
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
    }
    
    func isValidUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
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
