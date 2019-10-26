//
//  InsideRepoMainView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 17/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class InsideRepoMainView: UIViewController {
    
    let insideRepoContentView = InsideRepoContentView()
    
    var insideRepoViewModel: InsideRepoViewModel?
       
       convenience init(userViewModel: InsideRepoViewModel) {
           self.init()
           insideRepoViewModel = userViewModel
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        view = insideRepoContentView
    }
    
    fileprivate func bindViewModel() {
        insideRepoContentView.insideViewModel = insideRepoViewModel
        insideRepoContentView.delegate = self
    }
}

extension InsideRepoMainView: InsideRepoContentViewDelegate {
    func didUserTapped(user: User) {
        navigationController?.pushViewController(InsideUserMainView(userViewModel: InsideUserViewModel(user: user)), animated: true)
    }
    
    
}
