//
//  EmptyStateView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class EmptyStateView: UIView, ConfigurableView {
   
    
    let emptyImage: UIImageView = {
       let image = UIImageView(image: UIImage(named: "emptyState"))
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
       return image
    }()
    
    let emptyMessage = UILabel(textColor: .titleColor, font: .boldSystemFont(ofSize: 16))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emptyMessage.text = "Something went wrong"
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
           addSubviews([emptyImage, emptyMessage])
    }
       
    func setupConstraints() {
        
        emptyImage.cBuild(make: .centerInSuperView)
        
        emptyMessage.cBuild { (make) in
            make.top.equal(to: emptyImage.bottomAnchor, offsetBy: 10)
            make.leading.equal(to: emptyMessage.leadingAnchor)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
}
