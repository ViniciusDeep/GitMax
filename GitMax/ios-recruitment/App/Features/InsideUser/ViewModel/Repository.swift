//
//  Repository.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

struct Repository {
    
    func fetchRepositorie(withRepoUrl url: String, completion: @escaping ([Repositorie]) -> ()) {
        Providey<[Repositorie]>().request(router: .completedUser(url), withMethod: .get, params: nil) { (result) in
            switch result {
            case .failure(_):
                break
            case .success(let repositorie):
                completion(repositorie)
            }
        }
    }
}
