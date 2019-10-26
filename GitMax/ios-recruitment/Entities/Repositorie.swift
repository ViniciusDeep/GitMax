//
//  Repositorie.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

struct Repositorie: Decodable {
    
    var name: String
    var description: String?
    var starsCount: Int
    var language: String?
    var forksCount: Int
    var contributorsUrl: String?
    
    enum CodingKeys: String, CodingKey {
           case name
           case description
           case starsCount = "stargazers_count"
           case language
           case forksCount = "forks_count"
           case contributorsUrl = "contributors_url"
       }
    
    init() {
        self.name = ""
        self.description = ""
        self.language = ""
        self.starsCount = 0
        self.forksCount = 0
    }
    
}
