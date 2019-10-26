//
//  ListUserContentView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

protocol ListUserContentViewDelegate: class {
    func didUserTapped(user: User)
}

class ListUserContentView: UIView, ConfigurableView {
    
    let listUserViewModel = ListUserViewModel()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
     let activity = UIActivityIndicatorView()
     activity.style = .large
     activity.color = .white
     activity.startAnimating()
     return activity
    }()
    
    lazy var tableView: ActivityTableView = {
        let tableView = ActivityTableView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .backgroundColor
        tableView.register(cellType: ListUserViewCell.self)
        tableView.addRefreshAction(target: self, action: #selector(refreshTable))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let titleLabel = TitleLabel(text: "Users", font: UIFont.boldSystemFont(ofSize: 32), color: .titleColor)
    
    weak var delegate: ListUserContentViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = .backgroundColor
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func bindViewModel() {
        listUserViewModel.updateList = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func buildViewHierarchy() {
        addSubviews([tableView, titleLabel])
         addSubview(activityIndicator)
    }

    func setupConstraints() {
        
        titleLabel.cBuild { (make) in
            make.top.equal(to: safeAreaLayoutGuide.topAnchor, offsetBy: 32)
            make.leading.equal(to: leadingAnchor, offsetBy: 32)
        }
        
        
        tableView.cBuild { (make) in
            make.top.equal(to: titleLabel.bottomAnchor, offsetBy: 16)
            make.leading.equal(to: safeAreaLayoutGuide.leadingAnchor)
            make.bottom.equal(to: safeAreaLayoutGuide.bottomAnchor)
            make.trailing.equal(to: safeAreaLayoutGuide.trailingAnchor, offsetBy: -2)
        }
        
        activityIndicator.cBuild(make: .centerInSuperView)
        
    }
    
    @objc fileprivate func refreshTable() {
        bindViewModel()
        tableView.refreshControl?.endRefreshing()
    }
    
}

extension ListUserContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !listUserViewModel.rowsIsEmpty() {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
        return listUserViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ListUserViewCell.self)
        cell.setup(withViewModel: listUserViewModel.cellViewModel(forIndex: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didUserTapped(user: listUserViewModel.getUser(forIndex: indexPath.row))
    }
    
}

extension ListUserContentView {
    func didUserTapped(user: User) {
        delegate?.didUserTapped(user: user)
    }
}
