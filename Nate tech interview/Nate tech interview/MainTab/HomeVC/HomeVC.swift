//
//  HomeVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    private let viewModel = HomeVM()
    private let productFeedCVC = ProductFeedCVC()
    
    private var products = [API.ProductResponse]() {
        didSet {
            productFeedCVC.setProduct(products)
        }
    }
    
    override func viewDidLoad() {
        configureView()
        configureUI()
        getProducts()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        productFeedCVC.delegate = self
    }
    
    private func configureUI() {
        view.addSubview(productFeedCVC.view)
        productFeedCVC.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func getProducts() {
        API.getProducts() { [weak self] response in
            guard let strongSelf = self, let data = response?.data
            else { return }
            strongSelf.products = data.products
        }
    }
}

extension HomeVC: ProductFeedCVCDelegate {
    func productTapped(index: Int) {
        print("DEBUG:- tapped")
    }
    
}
