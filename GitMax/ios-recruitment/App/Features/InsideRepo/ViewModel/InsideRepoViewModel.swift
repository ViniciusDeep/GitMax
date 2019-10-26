//
//  InsideRepoViewModel.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 17/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

class InsideRepoViewModel {
    
    let repo: Repositorie?
    
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
    
    
    
    init(_ repo: Repositorie) {
        self.repo = repo
    }
    
    public func numberOfRows() -> Int {
    if self.userCellViewModels.count == 0 {
        self.fetchData()
    }
        return self.userCellViewModels.count
    }
    
 
   @objc func fetchData() {
    self.userRepository.fetchUsers(insideRepositorieSearch: repo?.contributorsUrl ?? "", completion: {
        self.userCellViewModels = $0.map { ListUserCellViewModel($0) }
    })
   }
   
   public func cellViewModel(forIndex index: Int) -> ListUserCellViewModel {
       if index < self.userCellViewModels.count {
           return self.userCellViewModels[index]
       }
       return ListUserCellViewModel(User())
   }
    
    public func getUser(forIndex index: Int) -> User {
        let userVM = self.cellViewModel(forIndex: index)
        return userVM.user ?? User()
    }
    
    public func rowsIsEmpty() -> Bool {
        if self.userCellViewModels.count == 0 {
               return true
        } else {
            return false
        }
    }
    
}
