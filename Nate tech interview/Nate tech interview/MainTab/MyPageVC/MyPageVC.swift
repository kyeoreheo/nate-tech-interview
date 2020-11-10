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
    public lazy var usernameInfoField = viewModel.informationField(
                    labelText: "username", textFieldText: " ")
    public lazy var emailInfoField = viewModel.informationField(
                    labelText: "email", textFieldText: " ")
    public lazy var addressInfoField = viewModel.informationField(
                    labelText: "address", textFieldText: " ",
                    action: #selector(changeAddress), target: self)
    public lazy var cardInfoField = viewModel.informationField(
                    labelText: "card", textFieldText: "**** **** **** 1234",
                    action: #selector(changeCreditCard), target: self)
    public lazy var phoneInfoField = viewModel.informationField(
                    labelText: "phone", textFieldText: "000 000 0000",
                    action: #selector(changePhone), target: self)
    
    private lazy var notificationView = viewModel.notificationView()
    private let msgNotificationSwitch = UISwitch()
    private let msgNotificationLabel = UILabel()
    
    // MARK:- Properties
    private lazy var viewModel = MyPageVM(self)
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        configureView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchUser()
    }
    
    // MARK:- Configures
    private func configureView() {
        view.backgroundColor = .white
    }
    
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
        msgNotificationSwitch.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
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

    @objc func changePhone() {
        pushVC(ChangePhoneVC())
    }
    
    @objc func changeAddress() {
        pushVC(ChangeAddresssVC())
    }
    
    @objc func changeCreditCard() {
        pushVC(ChangeCardVC())
    }
    
    @objc func toggleSwitch() {
        if msgNotificationSwitch.isOn {
            presentNotification()
            msgNotificationLabel.text = "We will send you msg when your\ndelivery status gets updated! 👍🏼"
        } else {
            msgNotificationLabel.text = "Do you want to get notified with message\nabout delivery status?"
        }
    }
    
    func presentNotification() {
        msgNotificationSwitch.isUserInteractionEnabled = false
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
                strongSelf.msgNotificationSwitch.isUserInteractionEnabled = true
            })}
        })
    }

}
