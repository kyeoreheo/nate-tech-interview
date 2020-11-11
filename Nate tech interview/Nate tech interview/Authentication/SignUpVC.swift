//
//  SignUpVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/10/20.
//

import UIKit
import SnapKit
import Firebase

class SignUpVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Propertiess
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private lazy var usernameTextField = CustomView().textField(placeHolder: "Username", target: self, action: #selector(usernameTextFieldDidhange), type: .name)
    private lazy var emailTextField = CustomView().textField(placeHolder: "Email", target: self, action: #selector(emailTextFieldDidChange), type: .email)
    private lazy var passwordTextField = CustomView().textField(placeHolder: "Password", target: self, action: #selector(passwordTextFieldDidchange), type: .password, buttonAction: #selector(toggleEyeButton))
    lazy var registerButton = CustomView().generalButton(isActive: false, text: "Register", target: self, action: #selector(registerUser))
    let warningLabel = UILabel()
    
    private lazy var popUpModal = CustomView().popUpModal(message: "Registered!", buttonText: "Log In", action: #selector(popVC), target: self)

    private lazy var viewModel = AuthenticationVM(self)
    var email = ""
    var password = ""
    var username = ""
    private var isPasswodHideen = true
    private var buttonConstraint: NSLayoutConstraint?

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeToShowKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    //MARK:- Helpers
    private func configure() {
        view.backgroundColor = .white
        warningLabel.isHidden = true
        popUpModal.isHidden = true
    }
    
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
        titleLabel.text = "Sign Up"
        titleLabel.textColor = .gray8
        titleLabel.font = .notoBlack(size: 24 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(usernameTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(warningLabel)
        warningLabel.textColor = .red
        warningLabel.font = UIFont.systemFont(ofSize: 12)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(registerButton)
        buttonConstraint = registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        buttonConstraint?.isActive = true
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        view.addSubview(popUpModal)
        popUpModal.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
    }
    
    @objc func registerUser() {
        let lowerCaseEmail = email.lowercased()
        let user = AuthProperties(email: lowerCaseEmail, password: password, username: username)

        API.registerUser(user: user) { [weak self] (error, ref) in
            guard let strongSelf = self,
                  let usernameTextField = strongSelf.usernameTextField.viewWithTag(1) as? UITextField,
                  let emailTextField = strongSelf.emailTextField.viewWithTag(1) as? UITextField,
                  let passwordTextField = strongSelf.passwordTextField.viewWithTag(1) as? UITextField
            else { return }
            
            if let error = error {
                strongSelf.warningLabel.isHidden = false
                strongSelf.warningLabel.text = error.localizedDescription
            } else {
                strongSelf.popUpModal.isHidden = false
                usernameTextField.resignFirstResponder()
                emailTextField.resignFirstResponder()
                passwordTextField.resignFirstResponder()
            }
        }
    }

    //MARK:- Selectors
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        guard let email = textField.text else { return }
        self.email = email
        viewModel.checkRegisterFormat()
    }
    
    @objc func passwordTextFieldDidchange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        self.password = password
        viewModel.checkRegisterFormat()
    }
    
    @objc func usernameTextFieldDidhange(_ textField: UITextField) {
        guard let username = textField.text else { return }
        self.username = username
        viewModel.checkRegisterFormat()
    }

    @objc func toggleEyeButton() {
        guard let button = passwordTextField.subviews[2] as? UIButton,
              let textField = passwordTextField.subviews[0] as? UITextField
        else { return }
        if isPasswodHideen {
            button.setImage(UIImage(named: "eyeOff"), for: .normal)
            textField.isSecureTextEntry = false
            isPasswodHideen = false
        } else {
            button.setImage(UIImage(named: "eyeOn"), for: .normal)
            textField.isSecureTextEntry = true
            isPasswodHideen = true
        }
    }
    
    //MARK:- Keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        buttonConstraint?.constant = (isBigPhone ? 50 + 8 : 16 + 16) - keyboardSize.cgRectValue.height - 48
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

