//
//  MainTabBar.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class MainTabBar: UITabBarController, UITabBarControllerDelegate {
    // MARK:- Properties
    private let viewModel = MainTabVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedIndex = 0
    }
    
    // MARK: - Configures
    private func configureTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .orange

        let homeTab = viewModel.barTabView(view: HomeVC(), image: "home")
        let searchTab = viewModel.barTabView(view: SearchVC(), image: "search")
        let myPageTab = viewModel.barTabView(view: MyPageVC(), image: "setting")
        
        viewControllers = [homeTab, searchTab, myPageTab]
    }
}
