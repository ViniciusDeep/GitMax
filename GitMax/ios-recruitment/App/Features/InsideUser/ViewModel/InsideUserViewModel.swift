//
//  InsideUserViewModel.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

class InsideUserViewModel {
    
    var user: User?

    typealias UpdateClosure = () -> Void
       
       private let repository = Repository()
       
       public var repoCellViewModels: [InsideUserRepoCellViewModel] = [] {
           didSet {
               DispatchQueue.main.async {
                   self.updateList?()
               }
           }
       }
       
    public var updateList: UpdateClosure?
    
    
    init(user: User) {
       self.user = user
    }
    
    public func rowsIsEmpty() -> Bool {
        if self.repoCellViewModels.count == 0 {
                 return true
          } else {
              return false
          }
      }
    
    
    func numberOfRepos() -> Int {
        if self.repoCellViewModels.count == 0 {
            self.fetchData()
        }
            return self.repoCellViewModels.count
    }
    
    @objc func fetchData() {
        repository.fetchRepositorie(withRepoUrl: user?.reposUrl ?? "https://api.github.com/users/ViniciusDeep/repos", completion: {
                self.repoCellViewModels = $0.map { InsideUserRepoCellViewModel($0) }
             })
    }
    
    public func getRepo(atIndex index: Int) -> Repositorie {
        let cellVM = cellViewModel(forIndex: index)
        return cellVM.repo ?? Repositorie()
    }
    
    
    public func cellViewModel(forIndex index: Int) -> InsideUserRepoCellViewModel {
        if index < self.repoCellViewModels.count {
            return self.repoCellViewModels[index]
        }
        return InsideUserRepoCellViewModel(Repositorie())
    }
    
    func fetchCompletedUser(completion: @escaping (User) -> ()) {
        guard let userUrl = user?.userUrl else {return}
        UserRepository().fetchUser(completedUrl: userUrl) { (user) in
            completion(user)
        }
    }
}
