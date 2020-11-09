//
//  SearchVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class OrderVC: UIViewController {
    // MARK:- View components
    private let titleLabel = UILabel()
    private let orderHistoryCVC = OrderHistoryCVC()
    
    // MARK:- Properties
    private lazy var viewModel = OrderVM(self)
    var products = [API.ProductResponse]() {
        didSet {
            orderHistoryCVC.products = products
        }
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        configure()
        configureUI()
    }
    // MARK:- Configures
    private func configure() {
        view.backgroundColor = .white
        viewModel.getProducts()
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.text = "Order History"
        titleLabel.textColor = .gray8
        titleLabel.font = .notoBlack(size: 24 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(orderHistoryCVC.view)
//        orderHistoryCVC.delegate = self
        orderHistoryCVC.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
