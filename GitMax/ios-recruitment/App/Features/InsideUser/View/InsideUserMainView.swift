//
//  InsideUserMainView.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class InsideUserMainView: UIViewController {
    
    var insideUserContentView = InsideUserContentView()
    
    var insideUserViewModel: InsideUserViewModel?
    
    convenience init(userViewModel: InsideUserViewModel) {
        self.init()
        insideUserViewModel = userViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = insideUserContentView
        navigationController?.navigationBar.tintColor = .actionColor
        insideUserContentView.delegate = self
        bindViewModel()
    }
    
    fileprivate func bindViewModel() {
        insideUserContentView.insideViewModel = insideUserViewModel
    }
}

extension InsideUserMainView: InsideUserContentViewDelegate {
    func didRepoTapped(repo: Repositorie) {
        navigationController?.pushViewController(InsideRepoMainView(userViewModel: InsideRepoViewModel(repo)), animated: true)
    }
}
