//
//  InsideUserRepoCell.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

struct InsideUserRepoCellViewModel {
    
    let repo: Repositorie?
    
    init(_ repo: Repositorie) {
        self.repo = repo
    }
}
