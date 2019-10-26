//
//  UserRepository.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

struct UserRepository {
    
    func fetchUsers(insideRepositorieSearch search: String, completion: @escaping ([User]) -> ()) {
        Providey<[User]>().request(router: .completedUser(search), withMethod: .get, params: nil) { (result) in
            switch result {
            case .failure(_):
                break
            case .success(let users):
                completion(users)
            }
        }
    }
    
    func fetchUsers(completion: @escaping ([User]) -> ()) {
        Providey<[User]>().request(router: .users, withMethod: .get, params: nil) { (result) in
            switch result {
            case .failure(_):
                break
            case .success(let users):
                completion(users)
            }
        }
    }
    
    func fetchUser(withSearch search: String, completion: @escaping (User) -> ()) {
        Providey<User>().request(router: .searchUser(search), withMethod: .get, params: nil) { (result) in
             switch result {
                       case .failure(_):
                            break
                       case .success(let user):
                           completion(user)
                       }
        }
    }
    
    func fetchUser(completedUrl: String, completion: @escaping (User) -> ()) {
        Providey<User>().request(router: .completedUser(completedUrl), withMethod: .get, params: nil) { (result) in
                   switch result {
                             case .failure(_):
                                 break
                             case .success(let user):
                                 completion(user)
                    }
              }
          }
}
