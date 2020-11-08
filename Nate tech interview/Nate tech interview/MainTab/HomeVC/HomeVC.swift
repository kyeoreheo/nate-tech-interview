//
//  HomeVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    private lazy var viewModel = HomeVM(self)
    private let productFeedCVC = ProductFeedCVC()
    
    var products = [API.ProductResponse]() {
        didSet {
            productFeedCVC.setProduct(products)
        }
    }

    override func viewDidLoad() {
        configureView()
        configureUI()
        viewModel.getProducts()
//        getProducts()
    }
    
    private func configureView() {
        view.backgroundColor = .white
//        productFeedCVC.delegate = self
    }
    
    private func configureUI() {
        view.addSubview(productFeedCVC.view)
        productFeedCVC.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
