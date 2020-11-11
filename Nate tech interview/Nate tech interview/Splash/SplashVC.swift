//
//  SplachVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class SplashVC: UIViewController {
    //MARK:- View components
    private let backgroundView = UIImageView()
    private let nateLabel = UILabel()
    private let contentLabel = UILabel()
    private let nameLabel = UILabel()
    private lazy var startButton = CustomView().generalButton(isActive: true, text: "START", target: self, action: #selector(presentLogInVC))
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGlobalVariables()
        configureUI()
//        presentMainTabBar()
    }
    
    private func configureUI() {
        view.addSubview(backgroundView)
        backgroundView.alpha = 0.5
        backgroundView.image = UIImage(named: "background")
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(nateLabel)
        nateLabel.text = "NATE"
        nateLabel.textColor = .gray2
        nateLabel.font = .notoBold(size: 110 * ratio)
        nateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100 * ratio)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(contentLabel)
        contentLabel.text = "iOS Challenge"
        contentLabel.textColor = .gray1
        contentLabel.font = .notoReg(size: 25 * ratio)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nateLabel.snp.bottom).offset(-16)
            make.right.equalTo(nateLabel)
        }
        
        view.addSubview(nameLabel)
        nameLabel.text = "by Kyeore Heo"
        nameLabel.textColor = .orange
        nameLabel.font = .notoBold(size: 20 * ratio)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
            make.right.equalTo(contentLabel.snp.right)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.height.equalTo(56 * ratio)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
    private func applyGlobalVariables() {
        let heightRatio: CGFloat = view.frame.height / 812.0
        ratio = heightRatio < 1 ? 1:heightRatio
        isBigPhone = view.frame.height > 750.0
        topSafeMargin = ( UIApplication.shared.windows.first{$0.isKeyWindow}?.safeAreaInsets.top ?? 0) as CGFloat
    }
    
    private func presentMainTabBar() {
//        DispatchQueue.main.async { [weak self] in
//            guard let strongSelf = self else { return }
//            let navigation = UINavigationController(rootViewController: MainTabBar())
//            navigation.modalPresentationStyle = .fullScreen
//            navigation.navigationBar.isHidden = true
//            strongSelf.present(navigation, animated: false, completion: nil)
//        }
    }
    
    @objc func presentLogInVC() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            let navigation = UINavigationController(rootViewController: LogInVC())
//            let navigation = UINavigationController(rootViewController: MainTabBar())

            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.isHidden = true
            strongSelf.present(navigation, animated: false, completion: nil)
        }
    }
}
