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
    private let versionLabel = UILabel()
    private lazy var usernameInfoField = viewModel.informationField(
                     labelText: "username", textFieldText: "Kyeore Heo")
    private lazy var emailInfoField = viewModel.informationField(
                     labelText: "email", textFieldText: "91kyoheo@gmail.com")
    private lazy var addressInfoField = viewModel.informationField(
                     labelText: "address", textFieldText: "45 River, Jersey City, NJ, 07310",
                     action: #selector(changeAddress), target: self)
    private lazy var cardInfoField = viewModel.informationField(
                     labelText: "card", textFieldText: "**** - **** - **** - 1234",
                     action: #selector(changeCreditCard), target: self)
    private lazy var phoneInfoField = viewModel.informationField(
                     labelText: "phone", textFieldText: "+1 917-123-1234",
                     action: #selector(changePhone), target: self)
    private let msgNotificationSwitch = UISwitch()
    private let msgNotificationLabel = UILabel()
    
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
        
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        else { return }
        view.addSubview(versionLabel)
        versionLabel.text = "\(String(describing: appVersion))(iOS\(UIDevice.current.systemVersion))"
        versionLabel.font = UIFont.notoReg(size: 12 * ratio)
        versionLabel.textColor = .gray5
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.right.equalToSuperview().offset(-24)
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
        
        view.addSubview(phoneInfoField)
        phoneInfoField.snp.makeConstraints { make in
            make.height.equalTo(88 * ratio)
            make.top.equalTo(cardInfoField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(msgNotificationSwitch)
        msgNotificationSwitch.tintColor = .gray3
        msgNotificationSwitch.onTintColor = .green
        msgNotificationSwitch.addTarget(self, action: #selector(toggleNotification), for: .touchUpInside)
        msgNotificationSwitch.snp.makeConstraints { make in
            make.height.equalTo(31 * ratio)
            make.top.equalTo(phoneInfoField.snp.bottom).offset(20.5)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(msgNotificationLabel)
        msgNotificationLabel.text = "Do you want to get notified with message\nabout delivery status?"
        msgNotificationLabel.numberOfLines = 0
        msgNotificationLabel.font = UIFont.notoReg(size: 14 * ratio)
        msgNotificationLabel.textColor = .gray8
        msgNotificationLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneInfoField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(msgNotificationSwitch.snp.left).offset(-8)
        }
    }
    
    @objc func toggleNotification() {
        
    }
    
    @objc func changePhone() {
    }
    
    @objc func changeAddress() {
        pushVC(ChangeAddresssVC())
    }
    
    @objc func changeCreditCard() {
        pushVC(ChangeCardVC())

    }

}
