//
//  LogInVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/10/20.
//

import UIKit

class LogInVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- View Components
    private let titleLabel = UILabel()
    lazy var emailTextField = CustomView().textField(placeHolder: "Email", target: self, action: #selector(emailTextFieldDidChange), type: .email)
    lazy var passwordTextField = CustomView().textField(placeHolder: "Password", target: self, action: #selector(passwordTextFieldDidchange), type: .password, buttonAction: #selector(toggleEyeButton))
    
    lazy var logInButton = CustomView().generalButton(isActive: false, text: "Log In", target: self, action: #selector(logIn))
    let warningLabel = UILabel()
    private let rememberMeButton = UIButton()
    private let rememberMeLabel = UILabel()
    private let forgotPasswordButton = UIButton()
    private let bottomLabel = UILabel()
    private let signUpLabel = UILabel()
    private let signUpButton = UIButton()
    
    //MARK:- Properties
    private lazy var viewModel = AuthenticationVM(self)
    var email = ""
    var password = ""
    private var isPasswodHideen = true
    private var buttonConstraint: NSLayoutConstraint?

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToShowKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    //MARK:- configure
    private func configureView() {
        view.backgroundColor = .white
        warningLabel.isHidden = true
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.text = "Log In"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(warningLabel)
        warningLabel.textColor = .red
        warningLabel.font = UIFont.boldSystemFont(ofSize: 12)
        warningLabel.numberOfLines = 0
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(rememberMeButton)
        rememberMeButton.backgroundColor = .white
        rememberMeButton.layer.cornerRadius = 5
        rememberMeButton.layer.borderWidth = 1.5
        rememberMeButton.layer.borderColor = UIColor.gray5.cgColor
        rememberMeButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(rememberMeLabel)
        rememberMeLabel.text = "Remember me"
        rememberMeLabel.textColor = .lightGray
        rememberMeLabel.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        rememberMeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rememberMeButton.snp.centerY)
            make.left.equalTo(rememberMeButton.snp.right).offset(10)
        }
        
        let crosssLine = UIView()
        view.addSubview(crosssLine)
        crosssLine.backgroundColor = .gray
        crosssLine.alpha = 0.7
        crosssLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.centerY.equalTo(rememberMeButton.snp.centerY)
            make.left.equalTo(rememberMeButton.snp.left)
            make.right.equalTo(rememberMeLabel.snp.right)
        }

        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.backgroundColor = .white
        forgotPasswordButton.setTitle("Forgot password", for: .normal)
        forgotPasswordButton.titleLabel?.underline()
        forgotPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        forgotPasswordButton.setTitleColor(.lightGray, for: .normal)
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(rememberMeButton.snp.centerY)
            make.right.equalToSuperview().offset(-30)
        }
        
        let crosssLine2 = UIView()
        view.addSubview(crosssLine2)
        crosssLine2.backgroundColor = .gray
        crosssLine2.alpha = 0.7
        crosssLine2.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.centerY.equalTo(forgotPasswordButton.snp.centerY)
            make.left.equalTo(forgotPasswordButton.snp.left)
            make.right.equalTo(forgotPasswordButton.snp.right)
        }
        
        view.addSubview(signUpLabel)
        signUpLabel.text = "Have no account?  Sing Up!"
        signUpLabel.textColor = .gray
        signUpLabel.font = UIFont.systemFont(ofSize: 12 * ratio)
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rememberMeButton.snp.bottom).offset(16)
        }
        
        view.addSubview(signUpButton)
        signUpButton.backgroundColor = .white
        signUpButton.addTarget(self, action: #selector(presentSignUpVC), for: .touchUpInside)
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.titleLabel?.underline()
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        signUpButton.setTitleColor(.orange, for: .normal)
        signUpButton.snp.makeConstraints { make in
            make.right.equalTo(signUpLabel.snp.right)
            make.centerY.equalTo(signUpLabel.snp.centerY)
        }
        
        view.addSubview(logInButton)
        buttonConstraint = logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        buttonConstraint?.isActive = true
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }

    //MARK:- Selectors
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        guard let email = textField.text else { return }
        self.email = email
        viewModel.checkLogInFormat()
    }
    
    @objc func passwordTextFieldDidchange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        self.password = password
        viewModel.checkLogInFormat()
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
    
    @objc func logIn() {
        let lowerCaseEmail = email.lowercased()
        
        if email != "" && password != "" {
            API.logIn(email: lowerCaseEmail, password: password) { [weak self] (result, error) in
                guard let strongSelf = self,
                      let emailTextField = strongSelf.emailTextField.viewWithTag(1) as? UITextField,
                      let passwordTextField = strongSelf.passwordTextField.viewWithTag(1) as? UITextField
                else { return }
                
                emailTextField.resignFirstResponder()
                passwordTextField.resignFirstResponder()
                
                if let error = error {
                    strongSelf.warningLabel.isHidden = false
                    strongSelf.warningLabel.text = error.localizedDescription
                    return
                }

                guard let result = result else { return }
                API.fetchUser(uid: result.user.uid) { response in
                    User.shared.setName(response.username)
                    User.shared.setEmail(response.email)
                    User.shared.setAddress(response.address)
                    User.shared.setCard(Card(number: response.card.number, cvv: ""))
                    User.shared.setPhone(response.phoneNumber)
                    
                    DispatchQueue.main.async {
                        let navigation = UINavigationController(rootViewController: MainTabBar())
                        navigation.modalPresentationStyle = .fullScreen
                        navigation.navigationBar.isHidden = true
                        strongSelf.present(navigation, animated: false, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func presentSignUpVC() {
        navigationController?.pushViewController(SignUpVC(), animated: true)
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
