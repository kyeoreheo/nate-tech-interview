//
//  ChangeEmailVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/8/20.
//

import UIKit

class ChangeAddresssVC: UIViewController {
    // MARK:- View components
    private let titleLabel = UILabel()
    private let backButton = UIButton()
    lazy var confirmButton = CustomView().generalButton(isActive: false,
                                     target: self, action: #selector(applyChanges))
    private lazy var streetTextField = CustomView().textField(placeHolder: "street",
                                     target: self,
                                     action: #selector(streetTextFieldDidChange),
                                     type: .address)
    private lazy var cityTextField = CustomView().textField(placeHolder: "city",
                                     target: self,
                                     action: #selector(cityTextFieldDidChange),
                                     type: .address)
    private lazy var stateTextField = CustomView().textField(placeHolder: "state",
                                     target: self,
                                     action: #selector(stateTextFieldDidChange),
                                     type: .address)
    private lazy var zipcodeTextField = CustomView().textField(placeHolder: "zipcode",
                                     target: self,
                                     action: #selector(zipcodeTextFieldDidChange),
                                     type: .phone)
    var address = Address(street: "", city: "", state: "", zipcode: "")
    private var buttonConstraint: NSLayoutConstraint?

    // MARK:- Properties
    private lazy var viewModel = MyPageVM(self)
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .white
        subscribeToShowKeyboardNotifications()
        configureUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }

    // MARK:- Configures
    private func configureUI() {
        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "arrow-left"), for: .normal)
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = "Edit Address"
        titleLabel.textColor = .gray8
        titleLabel.font = .notoBlack(size: 24 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(streetTextField)
        streetTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(cityTextField)
        cityTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(streetTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(view.snp.centerX).offset(-8)
        }
        
        view.addSubview(stateTextField)
        stateTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(streetTextField.snp.bottom).offset(16)
            make.left.equalTo(view.snp.centerX).offset(8)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(zipcodeTextField)
        zipcodeTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(cityTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(view.snp.centerX).offset(-8)
        }
        
        view.addSubview(confirmButton)
        buttonConstraint = confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        buttonConstraint?.isActive = true
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }

    }
    
    @objc func streetTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        address.street = text
        viewModel.checkAddressFormat()
    }
    
    @objc func cityTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count > 13 {
            textField.text = String(text.dropLast())
        }
        
        address.city = textField.text ?? ""
        viewModel.checkAddressFormat()
    }

    @objc func stateTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text?.uppercased()
        else { return }
        
        textField.text = text
        if text.count > 2 {
            textField.text = String(text.dropLast())
        }
        address.state = textField.text ?? ""
        viewModel.checkAddressFormat()
    }
    
    @objc func zipcodeTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if text.count > 5 {
            textField.text = String(text.dropLast())
        }
        address.zipcode = textField.text ?? ""
        viewModel.checkAddressFormat()
    }
    
    @objc func applyChanges() {
//        User.shared.setAddress(address)
        API.changeAddresss(address: address) { [weak self] error, ref in
            guard let stongSelf = self else { return }
            if error == nil {
                stongSelf.popVC()
            }
        }
    }
    
    //MARK:- Keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        buttonConstraint?.constant = (isBigPhone ? 50 + 8 : 16 + 16) - keyboardSize.cgRectValue.height
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
       
    @objc func keyboardWillHide(_ notification: Notification) {
        buttonConstraint?.constant = 0
        let userInfo = notification.userInfo
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}
