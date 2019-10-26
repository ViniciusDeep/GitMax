//
//  InsideTableHeaderView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class InsideTableHeaderView: UIView, ConfigurableView {
  
    let profileBannerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let userName = UILabel(textColor: .titleColor, font: UIFont.boldSystemFont(ofSize: 32))
    
    let bioLabel = UILabel(textColor: .titleColor, font: UIFont.italicSystemFont(ofSize: 16))
    
    let followers = InfoUserView(title: "Followers", value: 10)
    let following = InfoUserView(title: "Following", value: 10)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
          addSubviews([profileBannerImage, userName, bioLabel,followers, following])
    }
      
    func setupConstraints() {
          profileBannerImage.cBuild(height: UIScreen.main.bounds.height * 0.3)
                
                profileBannerImage.cBuild { (make) in
                    make.leading.equal(to: leadingAnchor)
                    make.trailing.equal(to: trailingAnchor)
                    make.top.equal(to: topAnchor)
                }
                
                userName.cBuild { (make) in
                    make.top.equal(to: profileBannerImage.bottomAnchor, offsetBy: 8)
                }
                
                userName.cBuild(make: .centerXInSuperView)
                
                
                bioLabel.cBuild { (make) in
                    make.top.equal(to: userName.bottomAnchor, offsetBy: 10)
                    make.leading.equal(to: leadingAnchor, offsetBy: 10)
                    make.trailing.equal(to: trailingAnchor, offsetBy: -10)
                }
                
                followers.cBuild { (make) in
                    make.leading.equal(to: leadingAnchor, offsetBy: 10)
                    make.top.equal(to: bioLabel.bottomAnchor, offsetBy: 10)
                }
                
                following.cBuild { (make) in
                    make.trailing.equal(to: trailingAnchor, offsetBy: -95)
                    make.top.equal(to: followers.topAnchor)
                }
        }
    
    
}
