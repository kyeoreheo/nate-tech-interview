//
//  AuthenticationVM.swift
//  Nate tech interview
//
//  Created by Kyo on 11/10/20.
//

import UIKit

class AuthenticationVM {
    private let viewController: Any
    
    init(_ vc: Any) {
        self.viewController = vc
    }
    
    func hideGuideOnKeyboard() {
        guard let vc = viewController as? LogInVC,
              let emailTextField = vc.emailTextField.viewWithTag(1) as? UITextField,
              let passwordTextField = vc.passwordTextField.viewWithTag(1) as? UITextField
        else { return }
        emailTextField.textContentType = .oneTimeCode
        passwordTextField.textContentType = .oneTimeCode
    }
    
    func checkRegisterFormat() {
        guard let vc = viewController as? SignUpVC
        else { return }
        vc.warningLabel.isHidden = true
        if vc.email != "" && vc.password != "" && vc.username != "" {
            vc.registerButton.backgroundColor = .orange
            vc.registerButton.setTitleColor(.white, for: .normal)
            vc.registerButton.layer.borderWidth = 0
            vc.registerButton.isEnabled = true
        } else {
            vc.registerButton.backgroundColor = .white
            vc.registerButton.setTitleColor(.gray5, for: .normal)
            vc.registerButton.layer.borderWidth = 2
            vc.registerButton.isEnabled = false
        }
    }
    
    func checkLogInFormat() {
        guard let vc = viewController as? LogInVC
        else { return }
        vc.warningLabel.isHidden = true
        if vc.email != "" && vc.password != "" {
            vc.logInButton.backgroundColor = .orange
            vc.logInButton.setTitleColor(.white, for: .normal)
            vc.logInButton.layer.borderWidth = 0
            vc.logInButton.isEnabled = true
        } else {
            vc.logInButton.backgroundColor = .white
            vc.logInButton.setTitleColor(.gray5, for: .normal)
            vc.logInButton.layer.borderWidth = 2
            vc.logInButton.isEnabled = false
        }
    }

}

