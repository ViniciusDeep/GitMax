//
//  InfoUserView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class InfoUserView: UIView, ConfigurableView {
 
    
    let titleLabel = UILabel(textColor: .subTitleColor, font: UIFont.boldSystemFont(ofSize: 12))
    
    let valueLabel = UILabel(textColor: .titleColor, font: UIFont.boldSystemFont(ofSize: 12))
    
    
    convenience init(title: String, value: Int) {
        self.init()
        titleLabel.text = title
        valueLabel.text = ":\(value)"
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
         addSubviews([titleLabel, valueLabel])
    }
     
     func setupConstraints() {
        titleLabel.cBuild { (make) in
            make.leading.equal(to: leadingAnchor)
            make.top.equal(to: topAnchor)
        }
        
        valueLabel.cBuild { (make) in
            make.leading.equal(to: titleLabel.trailingAnchor, offsetBy: 4)
            make.top.equal(to: topAnchor)
        }
     }
    
    func setValueLabel(withNumber number: Int?) {
        valueLabel.text = ": \(number ?? 0)"
    }

}
