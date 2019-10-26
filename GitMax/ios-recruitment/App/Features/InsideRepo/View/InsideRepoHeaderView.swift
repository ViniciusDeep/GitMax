//
//  InsideRepoHeaderView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 17/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class InsideRepoHeaderView: UIView, ConfigurableView {
    
     let repoIcon: UIImageView = {
           let image = UIImageView(image: UIImage(named: "repoIcon"))
           image.contentMode = .scaleToFill
           return image
       }()
       
       let nameRepo = UILabel(textColor: .titleColor, font: UIFont.boldSystemFont(ofSize: 26))
       
       let bioRepo = UILabel(textColor: .titleColor, font: UIFont.italicSystemFont(ofSize: 16))
    
       let stars = InfoUserView(title: "Stars: ⭐️ ", value: 10)
       let forks = InfoUserView(title: "Forks: 👨‍💻", value: 10)
       
       let languageRepo = UILabel(textColor: .titleColor, font: .italicSystemFont(ofSize: 14))
    
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       func buildViewHierarchy() {
             addSubviews([repoIcon, nameRepo, bioRepo,stars, forks, languageRepo])
       }
         
       func setupConstraints() {
             repoIcon.cBuild(height: UIScreen.main.bounds.height * 0.2)
                   
                   repoIcon.cBuild { (make) in
                       make.leading.equal(to: leadingAnchor)
                       make.trailing.equal(to: trailingAnchor)
                       make.top.equal(to: topAnchor)
                   }
                   
                   nameRepo.numberOfLines = 0
        
                   nameRepo.cBuild { (make) in
                       make.top.equal(to: repoIcon.bottomAnchor, offsetBy: 8)
                       make.trailing.equal(to: trailingAnchor, offsetBy: -10)
                   }
                   
                   nameRepo.cBuild(make: .centerXInSuperView)
                   
                   
                   bioRepo.cBuild { (make) in
                       make.top.equal(to: nameRepo.bottomAnchor, offsetBy: 10)
                       make.leading.equal(to: leadingAnchor, offsetBy: 10)
                       make.trailing.equal(to: trailingAnchor, offsetBy: -10)
                   }
                   
                   languageRepo.cBuild { (make) in
                        make.leading.equal(to: leadingAnchor, offsetBy: 10)
                        make.top.equal(to: bioRepo.bottomAnchor, offsetBy: 10)
                    }
        
        
                   stars.cBuild { (make) in
                       make.leading.equal(to: leadingAnchor, offsetBy: 10)
                       make.top.equal(to: languageRepo.bottomAnchor, offsetBy: 10)
                   }
                   
                   forks.cBuild { (make) in
                       make.trailing.equal(to: trailingAnchor, offsetBy: -95)
                       make.top.equal(to: stars.topAnchor)
                   }
           }
    
}
