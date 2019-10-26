//
//  InsideUserRepoCell.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Reusable

class InsideUserRepoCell: UITableViewCell, Reusable, ConfigurableView {
   
    
    let nameRepo = UILabel(textColor: .titleColor, font: .boldSystemFont(ofSize: 20))
    
    let descriptionRepo = UILabel(textColor: .subTitleColor, font: .italicSystemFont(ofSize: 16))
    
    let languageRepo = UILabel(textColor: .titleColor, font: .italicSystemFont(ofSize: 16))
    
    let starsRepo = UILabel(textColor: .titleColor, font: .italicSystemFont(ofSize: 16))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .backgroundColor
        setupView()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        nameRepo.text = "CBuilder"
        descriptionRepo.text = "🧡A Swift Autolayout DSL for iOS 📏📐🖌"
        languageRepo.text = "Language: Swift"
        starsRepo.text = "⭐️ : 42"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
           addSubviews([nameRepo, descriptionRepo, languageRepo, starsRepo])
    }
       
    func setupConstraints() {
        nameRepo.cBuild { (make) in
            make.top.equal(to: topAnchor,offsetBy: 10)
            make.leading.equal(to: leadingAnchor,offsetBy: 10)
        }
        
        descriptionRepo.cBuild { (make) in
            make.top.equal(to: nameRepo.bottomAnchor, offsetBy: 10)
            make.leading.equal(to: nameRepo.leadingAnchor, offsetBy: 10)
            make.trailing.equal(to: trailingAnchor, offsetBy: -10)
        }
        
        languageRepo.cBuild { (make) in
            make.top.equal(to: descriptionRepo.bottomAnchor, offsetBy: 10)
            make.leading.equal(to: leadingAnchor, offsetBy: 10)
        }
        
        starsRepo.cBuild { (make) in
            make.top.equal(to: languageRepo.topAnchor)
            make.trailing.equal(to: trailingAnchor, offsetBy: -10)
        }
    }
    
    func setup(withViewModel viewModel: InsideUserRepoCellViewModel) {
        guard let repo = viewModel.repo else {return }
        nameRepo.text = repo.name
        descriptionRepo.text = repo.description
        languageRepo.text = repo.language
        starsRepo.text = "⭐️ \(repo.starsCount)"
    }
    
}
