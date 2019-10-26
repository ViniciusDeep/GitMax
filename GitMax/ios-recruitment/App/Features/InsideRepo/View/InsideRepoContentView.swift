//
//  InsideRepoContentView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 17/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

protocol InsideRepoContentViewDelegate: class {
    func didUserTapped(user: User)
}

class InsideRepoContentView: UIView, ConfigurableView {
  
    var insideViewModel: InsideRepoViewModel? {
          didSet {
            headerTableView.nameRepo.text = insideViewModel?.repo?.name
            headerTableView.bioRepo.text = insideViewModel?.repo?.description
            headerTableView.languageRepo.text = insideViewModel?.repo?.language
            headerTableView.stars.setValueLabel(withNumber: insideViewModel?.repo?.starsCount)
            headerTableView.forks.setValueLabel(withNumber: insideViewModel?.repo?.forksCount)
          }
      }
    
    
    lazy var contributorsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: ColaboratorRepoCell.self)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .backgroundColor
        return tableView
    }()
    
    let headerTableView = InsideRepoHeaderView()
    
    weak var delegate: InsideRepoContentViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
          addSubviews([contributorsTableView])
    }
      
    func setupConstraints() {
        contributorsTableView.cBuild(make: .fillSuperview)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        insideViewModel?.updateList = {
            DispatchQueue.main.async {
                self.contributorsTableView.reloadData()
            }
        }
    }
    
}

extension InsideRepoContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insideViewModel?.numberOfRows() ?? 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didUserTapped(user: insideViewModel?.getUser(forIndex: indexPath.row) ?? User())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ColaboratorRepoCell.self)
        cell.setup(withViewModel: insideViewModel?.cellViewModel(forIndex: indexPath.row) ?? ListUserCellViewModel(User()))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewFactory.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerTableView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewFactory.headerHeightForRepos
    }
}

extension InsideRepoContentView {
    func didUserTapped(user: User) {
        delegate?.didUserTapped(user: user)
    }
}
