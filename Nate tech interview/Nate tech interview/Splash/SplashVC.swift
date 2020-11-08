//
//  SplachVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class SplashVC: UIViewController {
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackground()
        applyGlobalVariables()
        presentMainTabBar()
    }
    
    private func applyBackground() {
        view.backgroundColor = .orange
    }
    
    private func applyGlobalVariables() {
        let heightRatio: CGFloat = view.frame.height / 812.0
        ratio = heightRatio < 1 ? 1:heightRatio
        isBigPhone = view.frame.height > 750.0
        topSafeMargin = ( UIApplication.shared.windows.first{$0.isKeyWindow}?.safeAreaInsets.top ?? 0) as CGFloat
        bottomSafeMargin = (UIApplication.shared.windows.first{$0.isKeyWindow}?.safeAreaInsets.bottom ?? 0) as CGFloat
    }
    
    private func presentMainTabBar() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            let navigation = UINavigationController(rootViewController: MainTabBar())
            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.isHidden = true
            strongSelf.present(navigation, animated: false, completion: nil)
        }
    }

}
