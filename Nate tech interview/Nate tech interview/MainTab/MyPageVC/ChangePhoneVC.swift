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
        configureUI()
    }

    // MARK:- Configures
    private func configureUI() {
    }
}
