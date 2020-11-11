//
//  UIViewController+.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

extension UIViewController {
    // MARK:- Navigation
    func pushVC(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func presentVC(_ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            let navigation = UINavigationController(rootViewController: viewController)
            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.isHidden = true
            self.present(navigation, animated: animated, completion: nil)
        }
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
}
