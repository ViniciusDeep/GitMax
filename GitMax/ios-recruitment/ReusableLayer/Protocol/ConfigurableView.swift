//
//  ConfigurableView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

protocol ConfigurableView: UIView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupView()
}

extension ConfigurableView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
}
