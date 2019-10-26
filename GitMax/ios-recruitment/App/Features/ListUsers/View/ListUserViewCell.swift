//
//  ListUserViewCell.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

class ListUserViewCell: UITableViewCell, ConfigurableView, Reusable {
    
    fileprivate let userProfileImage: RoundImage = {
        let roundImage = RoundImage(frame: .zero)
        roundImage.heightAnchor.constraint(equalToConstant: 65).isActive = true
        roundImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        return roundImage
    }()
    
    fileprivate let userName = UILabel(textColor: .titleColor, font: .boldSystemFont(ofSize: 18))
    
    fileprivate let bioUser = UILabel(textColor: .subTitleColor, font: .italicSystemFont(ofSize: 16))
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.backgroundColor = .backgroundColor
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buildViewHierarchy() {
           addSubviews([userProfileImage, userName, bioUser])
    }
       
    func setupConstraints() {
        userProfileImage.cBuild(make: .centerYInSuperView)
        userProfileImage.cBuild { (make) in
            make.leading.equal(to: leadingAnchor, offsetBy: 10)
        }
        
        userName.cBuild { (make) in
            make.top.equal(to: userProfileImage.topAnchor)
            make.leading.equal(to: userProfileImage.trailingAnchor, offsetBy: 10)
        }
        
        bioUser.cBuild { (make) in
            make.top.equal(to: userName.bottomAnchor, offsetBy: 10)
            make.leading.equal(to: userName.leadingAnchor)
            make.trailing.equal(to: trailingAnchor, offsetBy: -20)
        }
        bioUser.numberOfLines = 2
        
    }
    
    public func setup(withViewModel viewModel: ListUserCellViewModel) {
        guard let imageURL = URL(string: viewModel.user?.imageUrl ?? "") else {return}
        userProfileImage.sd_setImage(with: imageURL)
        userName.text = viewModel.user?.userName
        viewModel.fetchCompletedUser { (user) in
            self.bioUser.text = user.bio
        }
    }
}
