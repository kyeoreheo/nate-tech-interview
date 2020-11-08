//
//  MyPageVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class MyPageVC: UIViewController {
    // MARK:- View components
    private let titleLabel = UILabel()
    private lazy var usernameInfoField = viewModel.informationField(
                     labelText: "username", textFieldText: "abc")
    private lazy var emailInfoField = viewModel.informationField(
                     labelText: "email", textFieldText: "abc")
    private lazy var addressInfoField = viewModel.informationField(
                     labelText: "address", textFieldText: "45 River, Jersey City, NJ, 07310",
                     action: #selector(changeAddress), target: self)
    private lazy var cardInfoField = viewModel.informationField(
                     labelText: "card", textFieldText: "**** - **** - **** - 1234",
                     action: #selector(changeAddress), target: self)
    
    // MARK:- Properties
    private lazy var viewModel = MyPageVM(self)
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .white
        configureUI()
    }
    
    // MARK:- Configures
    private func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.text = "My Page"
        titleLabel.textColor = .gray8
        titleLabel.font = .notoBlack(size: 24 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(usernameInfoField)
        usernameInfoField.snp.makeConstraints { make in
            make.height.equalTo(88 * ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(emailInfoField)
        emailInfoField.snp.makeConstraints { make in
            make.height.equalTo(88 * ratio)
            make.top.equalTo(usernameInfoField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(addressInfoField)
        addressInfoField.snp.makeConstraints { make in
            make.height.equalTo(88 * ratio)
            make.top.equalTo(emailInfoField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(cardInfoField)
        cardInfoField.snp.makeConstraints { make in
            make.height.equalTo(88 * ratio)
            make.top.equalTo(addressInfoField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    @objc func changeAddress() {
        
    }
    
    @objc func changeCreditCard() {
        
    }

}
