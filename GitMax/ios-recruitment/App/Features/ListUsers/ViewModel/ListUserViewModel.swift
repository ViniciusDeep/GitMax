//
//  ListUserViewModel.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

class ListUserViewModel {
    
    typealias UpdateClosure = () -> Void
    
    private let userRepository = UserRepository()
    
    public var userCellViewModels: [ListUserCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateList?()
            }
        }
    }
    
    public var updateList: UpdateClosure?
    
    public func numberOfRows() -> Int {
    if self.userCellViewModels.count == 0 {
        self.fetchData()
    }
        return self.userCellViewModels.count
    }
    
    public func rowsIsEmpty() -> Bool {
        if self.userCellViewModels.count == 0 {
               return true
        } else {
            return false
        }
    }
    
    @objc func fetchData() {
        self.userRepository.fetchUsers(completion: {
            self.userCellViewModels = $0.map { ListUserCellViewModel($0) }
        })
    }
    
    public func cellViewModel(forIndex index: Int) -> ListUserCellViewModel {
        if index < self.userCellViewModels.count {
            return self.userCellViewModels[index]
        }
        return ListUserCellViewModel(User())
    }
    
    public func cellViewModel(withSearch search: String) {
        userRepository.fetchUser(withSearch: search) { (user) in
            self.userCellViewModels.insert(ListUserCellViewModel(user), at: 0)
        }
    }
    
    public func getUser(forIndex index: Int) -> User {
        let userVM = self.cellViewModel(forIndex: index)
        return userVM.user ?? User()
    }
    
    private func removeDuplicates() {
        let userCellViewModelsState = userCellViewModels
        
        userCellViewModels.forEach { (element) in
            userCellViewModelsState.forEach { (stateElement) in
                if stateElement.user?.userName == element.user?.userName {
                    self.userCellViewModels.remove(at: 0)
                }
            }
        }
    }
}




