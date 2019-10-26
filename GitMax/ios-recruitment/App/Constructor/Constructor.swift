//
//  Constructor.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

struct Constructor {
    
    static func getWindow(windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: ListUserMainView())
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.barTintColor = .backgroundColor
        navigation.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleColor]
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleColor]
        navigation.view.backgroundColor =  .backgroundColor
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        return window
    }
}
