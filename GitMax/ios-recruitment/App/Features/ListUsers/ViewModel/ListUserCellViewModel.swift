//
//  ListUserCellViewModel.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

struct ListUserCellViewModel {
    
    let user: User?
    
    init(_ user: User) {
        self.user = user
    }
    
    func fetchCompletedUser(completion: @escaping (User) -> ()) {
          guard let userUrl = user?.userUrl else {return}
          UserRepository().fetchUser(completedUrl: userUrl) { (user) in
              completion(user)
          }
      }
    
    
}
