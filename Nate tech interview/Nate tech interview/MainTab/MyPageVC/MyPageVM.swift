//
//  MyPageVM.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class MyPageVM {
    private let viewController: Any
    
    init(_ vc: Any) {
        self.viewController = vc
    }
    /// InformationTextField with button
    func informationField(labelText: String, textFieldText: String, action: Selector? = nil, target: Any? = nil) -> UIView {
        let view = UIView()
        let label = UILabel()
        let button = UIButton()
        let frame = UIImageView()
        let textFieldLabel = UILabel()
        
        view.addSubview(label)
        label.text = labelText
        label.font = UIFont.notoReg(size: 14 * ratio)
        label.textColor = .gray8
        label.adjustsFontSizeToFitWidth = true
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        if let action = action, let target = target {
            view.addSubview(button)
            button.setTitle("EDIT", for: .normal)
            button.setTitleColor(.gray4, for: .normal)
            button.titleLabel?.font = UIFont.notoBold(size: 14 * ratio)
            button.layer.borderColor = UIColor.gray4.cgColor
            button.layer.borderWidth = 1.5
            button.layer.cornerRadius = 8
            button.addTarget(target, action: action, for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.width.equalTo(90 * ratio)
                make.height.equalTo(56 * ratio)
                make.top.equalTo(label.snp.bottom).offset(12)
                make.bottom.equalToSuperview()
                make.right.equalToSuperview()
            }
        }
        
        view.addSubview(frame)
        frame.backgroundColor = .gray2
        frame.layer.borderColor = UIColor.gray4.cgColor
        frame.layer.borderWidth = 1.5
        frame.layer.cornerRadius = 8
        frame.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(label.snp.bottom).offset(12)
            make.left.equalToSuperview()
            if action == nil {
                make.right.equalToSuperview()
            } else {
                make.right.equalTo(button.snp.left).offset(-8)
            }
        }
        
        view.addSubview(textFieldLabel)
        textFieldLabel.tag = 1
        textFieldLabel.text = textFieldText
        textFieldLabel.font = UIFont.notoReg(size: 16)
        textFieldLabel.textColor = .gray5
        textFieldLabel.snp.makeConstraints { make in
            make.centerY.equalTo(frame.snp.centerY)
            make.left.equalTo(frame.snp.left).offset(16)
            make.right.equalTo(frame.snp.right).offset(-8)
        }

        return view
    }
    
    func generalButton(isActive: Bool, text: String = "Confirm", buttonColor: UIColor = .orange, textColor: UIColor = .white, target: Any, action: Selector) -> UIButton {
        let button = UIButton(type: .system)

        button.backgroundColor = isActive ? buttonColor : .white
        button.setTitleColor(isActive ? textColor : .gray5, for: .normal)
        button.layer.borderColor = UIColor.gray2.cgColor
        button.layer.borderWidth = isActive ? 0 : 2
        button.layer.cornerRadius = 5
        button.setTitle(text, for:.normal)
        button.titleLabel?.font = UIFont.notoBold(size: 14 * ratio)
        button.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
        button.isEnabled = isActive

        return button
    }
    
    func textField(placeHolder: String, target: Any, action: Selector, type: TextFieldType, isSmall: Bool = false) -> UIView {
        let view = UIView()
        let textField = UITextField()
        let divider = UIImageView()
        
        view.addSubview(textField)
        textField.tag = 1
        textField.textColor = .gray8
        if isSmall {
            textField.font = UIFont.notoReg(size: 16 * ratio)
            textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray6, NSAttributedString.Key.font: UIFont.notoReg(size: 16 * ratio)])
        } else {
            textField.font = UIFont.notoBold(size: 24 * ratio)
            textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray6, NSAttributedString.Key.font: UIFont.notoBold(size: 24 * ratio)])
        }
        textField.delegate = target as? UITextFieldDelegate
        textField.addTarget(target, action: action, for: .editingChanged)
        textField.autocorrectionType = .no
        
        switch type {
        case .phone, .card:
            textField.keyboardType = .numberPad
        case .email:
            textField.keyboardType = .emailAddress
        case .password:
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
        case .address:
            textField.keyboardType = .default
        }

        textField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        view.addSubview(divider)
        divider.contentMode = .scaleAspectFit
        divider.clipsToBounds = true
        divider.isUserInteractionEnabled = true
        divider.backgroundColor = .gray5
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        return view
    }
    
    func checkAddressFormat() {
        guard let vc = viewController as? ChangeAddresssVC
        else { return }
        if vc.address.street != "" && vc.address.city != "" && vc.address.state.count >= 2 && vc.address.zipcode.count >= 5 {
            vc.confirmButton.backgroundColor = .orange
            vc.confirmButton.setTitleColor(.white, for: .normal)
            vc.confirmButton.layer.borderWidth = 0
            vc.confirmButton.isEnabled = true
        } else {
            vc.confirmButton.backgroundColor = .white
            vc.confirmButton.setTitleColor(.gray5, for: .normal)
            vc.confirmButton.layer.borderWidth = 2
            vc.confirmButton.isEnabled = false
        }
    }
    
    func checkCardFormat() {
        guard let vc = viewController as? ChangeCardVC
        else { return }
        if (vc.cardNumber.count == 19) && (vc.cvv.count == 3) {
            vc.confirmButton.backgroundColor = .orange
            vc.confirmButton.setTitleColor(.white, for: .normal)
            vc.confirmButton.layer.borderWidth = 0
            vc.confirmButton.isEnabled = true
        } else {
            vc.confirmButton.backgroundColor = .white
            vc.confirmButton.setTitleColor(.gray5, for: .normal)
            vc.confirmButton.layer.borderWidth = 2
            vc.confirmButton.isEnabled = false
        }
    }
    
    func checkPhoneNumberFormat() {
        guard let vc = viewController as? ChangePhoneVC
        else { return }
        
        if vc.phoneNumber.count == 12 {
            vc.confirmButton.backgroundColor = .orange
            vc.confirmButton.setTitleColor(.white, for: .normal)
            vc.confirmButton.layer.borderWidth = 0
            vc.confirmButton.isEnabled = true
        } else {
            vc.confirmButton.backgroundColor = .white
            vc.confirmButton.setTitleColor(.gray5, for: .normal)
            vc.confirmButton.layer.borderWidth = 2
            vc.confirmButton.isEnabled = false
        }
    }
    
    func notificationView(text: String = "You will recieve delivery status") -> UIView {
        let view = UIView()
        let frame = UIImageView()
        let checkMark = UIImageView()
        let cover = UIImageView()
        let label = UILabel()
        
        view.backgroundColor = .clear
        
        view.addSubview(frame)
        frame.layer.cornerRadius = 8
        frame.backgroundColor = .green
        frame.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        view.addSubview(cover)
        
        view.addSubview(checkMark)
        checkMark.image = UIImage(named: "oval-check-green")
        checkMark.snp.makeConstraints { make in
            make.width.height.equalTo(24 * ratio)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }

        cover.backgroundColor = .white
        cover.layer.cornerRadius = 24 * ratio * 0.7 / 2
        cover.snp.makeConstraints { make in
            make.width.height.equalTo(24 * ratio * 0.7)
            make.center.equalTo(checkMark.snp.center)
        }
        
        view.addSubview(label)
        label.text = text
        label.textColor = .gray0
        label.font = UIFont.notoBold(size: 14 * ratio)
        label.adjustsFontSizeToFitWidth = true
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(checkMark.snp.right).offset(8)
        }

        return view
    }
    
    func fetchUser() {
        guard let vc = viewController as? MyPageVC,
              let username = vc.usernameInfoField.viewWithTag(1) as? UILabel,
              let email = vc.emailInfoField.viewWithTag(1) as? UILabel,
              let address = vc.addressInfoField.viewWithTag(1) as? UILabel,
              let card = vc.cardInfoField.viewWithTag(1) as? UILabel,
              let phone = vc.phoneInfoField.viewWithTag(1) as? UILabel
        else { return }
        
        username.text = User.shared.name
        email.text = User.shared.email
        address.text = User.shared.addresToString()
        card.text = User.shared.card.number
        phone.text = User.shared.phone
    }
   
}
