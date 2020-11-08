//
//  HomeVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    // MARK:- Properties
    private lazy var viewModel = HomeVM(self)
    private let productFeedCVC = ProductFeedCVC()
    var products = [API.ProductResponse]() {
        didSet {
            productFeedCVC.products = products
        }
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        configureUI()
        viewModel.getProducts()
    }
    
    // MARK:- Configures
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(productFeedCVC.view)
        productFeedCVC.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
