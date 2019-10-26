//
//  InsideUserContentView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

protocol InsideUserContentViewDelegate: class {
    func didRepoTapped(repo: Repositorie)
}

class InsideUserContentView: UIView, ConfigurableView {
  
    var insideViewModel: InsideUserViewModel! {
        didSet {
            guard let imageUrl = URL(string: insideViewModel.user?.imageUrl ?? "") else {return}
            headerTableView.profileBannerImage.sd_setImage(with: imageUrl)
            headerTableView.userName.text = insideViewModel.user?.userName
            insideViewModel.fetchCompletedUser { (user) in
                self.headerTableView.followers.setValueLabel(withNumber: user.followers)
                self.headerTableView.following.setValueLabel(withNumber: user.following)
                self.headerTableView.bioLabel.text = user.bio
            }
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
     let activity = UIActivityIndicatorView()
     activity.style = .large
     activity.color = .white
     activity.startAnimating()
     return activity
    }()

    let headerTableView = InsideTableHeaderView()
    
    var headerMasklayer: CAShapeLayer!
    
    lazy var insideUserRepoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: InsideUserRepoCell.self)
        tableView.backgroundColor = .backgroundColor
        return tableView
    }()
    
    weak var delegate: InsideUserContentViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        self.backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
         addSubviews([insideUserRepoTableView])
         insideUserRepoTableView.addSubview(activityIndicator)
    }
     
     func setupConstraints() {
        insideUserRepoTableView.cBuild { (make) in
            make.top.equal(to: topAnchor)
            make.leading.equal(to: leadingAnchor)
            make.trailing.equal(to: trailingAnchor)
            make.bottom.equal(to: bottomAnchor)
        }
        
        activityIndicator.cBuild(make: .centerInSuperView)
     }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        insideViewModel.updateList = {
            DispatchQueue.main.async {
                self.insideUserRepoTableView.reloadData()
            }
        }

    }
}

extension InsideUserContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewFactory.headerHeight
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !insideViewModel.rowsIsEmpty() {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
        return insideViewModel.numberOfRepos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InsideUserRepoCell.self)
        cell.setup(withViewModel: insideViewModel.cellViewModel(forIndex: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didRepoTapped(repo: insideViewModel.getRepo(atIndex: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewFactory.rowHeight
    }
}

extension InsideUserContentView {
    func didRepoTapped(repo: Repositorie) {
        delegate?.didRepoTapped(repo: repo)
    }
}
