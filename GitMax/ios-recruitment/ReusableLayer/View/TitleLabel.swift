//
//  TitleLabel.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class TitleLabel: UILabel, ConfigurableView {
    
    let acessoryRectView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        acessoryRectView.backgroundColor = .actionColor
        buildViewHierarchy()
        setupConstraints()
    }
    
    convenience init(text: String, color: UIColor) {
        self.init()
        self.text = text
        textColor = color
    }
    
    convenience init(text: String, font: UIFont, color: UIColor) {
        self.init()
        self.text = text
        self.font = font
        textColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(acessoryRectView)
    }
    
    func setupConstraints() {
        acessoryRectView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        acessoryRectView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        acessoryRectView.cBuild { make in
            make.leading.equal(to: leadingAnchor, offsetBy: -16)
            make.height.equal(to: heightAnchor, offsetBy: 16)
        }
    }
    
}

