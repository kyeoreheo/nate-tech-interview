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
    private lazy var notificationView = CustomView().notificationView(text: "Successfully purchased an item!")

    // MARK:- Properties
    private lazy var viewModel = HomeVM(self)
    var products = [API.ProductResponse]() {
        didSet {
            productFeedCVC.products = products
        }
    }
    
    // MARK:- Lifecycles
    override func viewDidLoad() {
        configureView()
        configureUI()
    }
    
    // MARK:- Configures
    private func configureView() {
        view.backgroundColor = .white
        viewModel.getProducts()
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.text = "Trand Items"
        titleLabel.textColor = .gray8
        titleLabel.font = .notoBlack(size: 24 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(productFeedCVC.view)
        productFeedCVC.delegate = self
        productFeedCVC.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
            
}

// MARK:- Extension
extension HomeVC: ProductCellDelegate {
    func purchasedButtonTapped(completion: @escaping (Bool?) -> Void) {
        view.isUserInteractionEnabled = false
        view.addSubview(notificationView)
        notificationView.alpha = 0
        notificationView.snp.makeConstraints { make in
            make.height.equalTo(48 * ratio)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn,
        animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.notificationView.alpha = 1
            strongSelf.notificationView.frame.origin.y += (48 * ratio) + 16
        },
        completion: { [weak self] finished in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn,
            animations: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.notificationView.alpha = 0
                strongSelf.notificationView.frame.origin.y -= (48 * ratio) + 16
            },
            completion:  { [weak self] finished in
                guard let strongSelf = self else { return }
                strongSelf.notificationView.removeFromSuperview()
                strongSelf.view.isUserInteractionEnabled = true
                completion(true)
            })}
        })
    }
    
}
