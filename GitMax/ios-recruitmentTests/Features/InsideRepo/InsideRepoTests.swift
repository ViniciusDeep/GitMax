//
//  InsideRepoTests.swift
//  ios-recruitmentTests
//
//  Created by Vinicius Mangueira on 17/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import XCTest
@testable import ios_recruitment

class InsideRepoTests: XCTestCase {
    
    var insideRepoViewModelStub: InsideRepoViewModel?
    
    func testInsideRepoViewModel() {
        var repositorie = Repositorie()
        repositorie.name = "Swift"
        
        insideRepoViewModelStub = InsideRepoViewModel(repositorie)
        
        XCTAssertEqual(insideRepoViewModelStub?.repo?.name, repositorie.name)
        
        var user = User()
        
        user.userName = "Lattner Stub"
        
        let userCellViewModelStub = ListUserCellViewModel(user)
        
        
        insideRepoViewModelStub?.userCellViewModels.append(userCellViewModelStub)
        
        XCTAssertEqual(insideRepoViewModelStub?.cellViewModel(forIndex: 0).user?.userName,userCellViewModelStub.user?.userName)
        
        
        XCTAssertEqual(insideRepoViewModelStub?.numberOfRows(),1)
        
        XCTAssertEqual(insideRepoViewModelStub?.getUser(forIndex: 0).userName, user.userName)
        
        XCTAssertEqual(insideRepoViewModelStub?.rowsIsEmpty(), false)
    }
}
