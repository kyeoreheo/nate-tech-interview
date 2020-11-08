//
//  HomeVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    // MARK:- View components
    private let titleLabel = UILabel()
    private let productFeedCVC = ProductFeedCVC()

    // MARK:- Properties
    private lazy var viewModel = HomeVM(self)
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
        view.addSubview(titleLabel)
        titleLabel.text = "Trand Items"
        titleLabel.textColor = .gray8
        titleLabel.font = .notoBlack(size: 24 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.left.equalToSuperview().offset(24)
        }
        
        view.backgroundColor = .white
        view.addSubview(productFeedCVC.view)
        productFeedCVC.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
