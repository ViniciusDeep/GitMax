//
//  CustomTabBarController.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

private protocol ConfigurableTabBar {
    func setupTabBar()
    func createNavigation(viewController: UIViewController, title: String, imageNamed: String) -> UINavigationController
}

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBar()
    }

    func showControllerModal(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}

extension CustomTabBarController: ConfigurableTabBar,  UITabBarControllerDelegate {
    fileprivate func setupTabBar() {
        self.viewControllers = [
            createNavigation(viewController: ListUserMainView(), title: "Users", imageNamed: "tab1"),
        ]
        view.backgroundColor = .backgroundColor
        tabBar.tintColor = .actionColor
        tabBar.unselectedItemTintColor = .tabBarIcon
        tabBar.barTintColor = .subBackground
        tabBar.isTranslucent = false
    }
    
    fileprivate func createNavigation(viewController: UIViewController, title: String, imageNamed: String) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.barTintColor = .backgroundColor
        navigation.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleColor]
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleColor]
        viewController.view.backgroundColor =  .backgroundColor
        navigation.tabBarItem.image = UIImage(named: imageNamed)
        navigation.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        return navigation
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

