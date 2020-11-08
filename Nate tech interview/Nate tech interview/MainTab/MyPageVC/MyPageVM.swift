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
}
