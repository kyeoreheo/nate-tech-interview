//
//  CustomView.swift
//  Nate tech interview
//
//  Created by Kyo on 11/10/20.
//

import UIKit

class CustomView {
    func statusBar() -> UIView {
        let view = UIView()
        let receivedCircle = UIView()
        let receivedLabel = UILabel()
        let bar1 = UIView()
        let shippedCircle = UIView()
        let shippedLabel = UILabel()
        let bar2 = UIView()
        let deliveredCircle = UIView()
        let deliveredLabel = UILabel()
        let circleSize: CGFloat = 30 * ratio
        view.addSubview(bar1)
        view.addSubview(bar2)
        view.addSubview(receivedCircle)
        receivedCircle.tag = 1
        receivedCircle.backgroundColor = .gray5
        receivedCircle.layer.cornerRadius = circleSize / 2
        receivedCircle.snp.makeConstraints { make in
            make.width.height.equalTo(circleSize)
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(receivedLabel)
        receivedLabel.text = "received"
        receivedLabel.textColor = .gray5
        receivedLabel.font = .notoReg(size: 12 * ratio)
        receivedLabel.snp.makeConstraints { make in
            make.top.equalTo(receivedCircle.snp.bottom).offset(4)
            make.centerX.equalTo(receivedCircle.snp.centerX)
        }
        
        view.addSubview(shippedCircle)
        shippedCircle.tag = 2
        shippedCircle.backgroundColor = .gray5
        shippedCircle.layer.cornerRadius = circleSize / 2
        shippedCircle.snp.makeConstraints { make in
            make.width.height.equalTo(circleSize)
            make.center.equalToSuperview()
        }
        
        view.addSubview(shippedLabel)
        shippedLabel.text = "shipped"
        shippedLabel.textColor = .gray5
        shippedLabel.font = .notoReg(size: 12 * ratio)
        shippedLabel.snp.makeConstraints { make in
            make.top.equalTo(shippedCircle.snp.bottom).offset(4)
            make.centerX.equalTo(shippedCircle.snp.centerX)
        }
        
        view.addSubview(deliveredCircle)
        deliveredCircle.tag = 3
        deliveredCircle.layer.cornerRadius = circleSize / 2
        deliveredCircle.backgroundColor = .gray5
        deliveredCircle.snp.makeConstraints { make in
            make.width.height.equalTo(circleSize)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(deliveredLabel)
        deliveredLabel.text = "delivered"
        deliveredLabel.textColor = .gray5
        deliveredLabel.font = .notoReg(size: 12 * ratio)
        deliveredLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveredCircle.snp.bottom).offset(4)
            make.centerX.equalTo(deliveredCircle.snp.centerX)
        }
        
        bar1.tag = 10
        bar1.backgroundColor = .gray5
        bar1.snp.makeConstraints { make in
            make.height.equalTo(5 * ratio)
            make.left.equalTo(receivedCircle.snp.centerX)
            make.right.equalTo(shippedCircle.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        bar2.tag = 20
        bar2.backgroundColor = .gray5
        bar2.snp.makeConstraints { make in
            make.height.equalTo(5 * ratio)
            make.left.equalTo(shippedCircle.snp.centerX)
            make.right.equalTo(deliveredCircle.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        return view
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
    
    func textField(placeHolder: String, target: Any, action: Selector, type: TextFieldType, isSmall: Bool = false, buttonAction: Selector? = nil) -> UIView {
        let view = UIView()
        let textField = UITextField()
        let divider = UIImageView()
        let sideButton = UIButton()
        
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
        case .address, .name:
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
        
        if let buttonAction = buttonAction {
            view.addSubview(sideButton)
            sideButton.setImage(UIImage(named: "eyeOn"), for: .normal)
            sideButton.tintColor = .gray
            sideButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            sideButton.addTarget(target, action: buttonAction, for: .touchUpInside)
            sideButton.snp.makeConstraints { make in
                make.width.height.equalTo(20)
                make.top.equalToSuperview().offset(6)
                make.right.equalToSuperview()
            }
        }

        return view
    }
    
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
    
    func popUpModal(message: String, buttonText: String, action: Selector, target: Any) -> UIView {
        let view = UIView()
        let coverView = UIView()
        let frameView = UIView()
        let messageLabel = UILabel()
        let button = UIButton()
        view.backgroundColor = .clear
        view.addSubview(coverView)
        coverView.backgroundColor = .black
        coverView.alpha = 0.4
        coverView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }

        view.addSubview(frameView)
        frameView.backgroundColor = .white
        frameView.clipsToBounds = true
        frameView.layer.cornerRadius = 10
        frameView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(250)
        }

        frameView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }

        frameView.addSubview(button)
        button.backgroundColor = .orange
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.bottom.equalToSuperview()
        }
        
        return view
    }
}
