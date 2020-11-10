//
//  ChangePhoneVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/8/20.
//


import UIKit

class ChangePhoneVC: UIViewController {
    // MARK:- View components
    private let titleLabel = UILabel()
    private let backButton = UIButton()
    lazy var confirmButton = viewModel.generalButton(isActive: false,
                                     target: self, action: #selector(applyChanges))
    private lazy var phoneNumberTextField = viewModel.textField(placeHolder: "card number",
                                     target: self,
                                     action: #selector(cardNumberTextFieldDidChange),
                                     type: .phone)
    // MARK:- Properties
    private lazy var viewModel = MyPageVM(self)
    var phoneNumber = ""
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .white
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeToShowKeyboardNotifications()
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
        titleLabel.text = "Edit Phone Number"
        titleLabel.textColor = .gray8
        titleLabel.font = .notoBlack(size: 24 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
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
    
    @objc func cardNumberTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count > 12 {
           textField.text = String(text.dropLast())
        }
        if (phoneNumber.count == 4 && text.count == 3) ||
           (phoneNumber.count == 8 && text.count == 7) {
           textField.text = String(text.dropLast())
        } else if text.count == 3 || text.count == 7 {
           textField.text = text + " "
        }
        phoneNumber = textField.text ?? ""
        viewModel.checkPhoneNumberFormat()
    }

    @objc func applyChanges() {
        User.shared.setPhone(phoneNumber)
        popVC()
    }
}
