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
}

