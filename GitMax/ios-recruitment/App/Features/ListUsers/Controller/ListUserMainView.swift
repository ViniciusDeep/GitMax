//
//  ViewController.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class ListUserMainView: UIViewController {

    let listUserContentView = ListUserContentView()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view = listUserContentView
        listUserContentView.delegate = self
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
           definesPresentationContext = true
           navigationController?.navigationBar.tintColor = .actionColor
           navigationItem.searchController = self.searchController
           navigationItem.hidesSearchBarWhenScrolling = false
           searchController.searchBar.delegate = self
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .titleColor
       }
    
    
}

extension ListUserMainView: ListUserContentViewDelegate, UISearchBarDelegate {
    func didUserTapped(user: User) {
        navigationController?.pushViewController(InsideUserMainView(userViewModel: InsideUserViewModel(user: user)), animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        listUserContentView.listUserViewModel.cellViewModel(withSearch: textFieldInsideSearchBar?.text ?? "")
    }
    
}


