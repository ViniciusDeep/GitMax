//
//  ListUsersTests.swift
//  ios-recruitmentTests
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import ios_recruitment

class ListUsersTests: XCTestCase {
    
    let listUserViewModelStub = ListUserViewModel()
    
    var listUserCellViewModel: ListUserCellViewModel?
    
    
    func testListUserViewModel() {
        var user = User()
        user.userName = "Vinicius"
        user.bio = "Bio"
        user.followers = 181
        
        listUserCellViewModel = ListUserCellViewModel(user)
        
        
        listUserViewModelStub.userCellViewModels.append(listUserCellViewModel ?? ListUserCellViewModel(user))
        
        
        XCTAssertEqual(listUserViewModelStub.cellViewModel(forIndex: 0).user?.userName, listUserCellViewModel?.user?.userName)
        XCTAssertEqual(listUserViewModelStub.cellViewModel(forIndex: 0).user?.bio, listUserCellViewModel?.user?.bio)
        XCTAssertEqual(listUserViewModelStub.cellViewModel(forIndex: 0).user?.followers, listUserCellViewModel?.user?.followers)
        
        
        XCTAssertEqual(listUserViewModelStub.numberOfRows(), 1)
        
        XCTAssertEqual(listUserViewModelStub.rowsIsEmpty(), false)
        
        XCTAssertEqual(listUserViewModelStub.getUser(forIndex: 0).userName, user.userName)
    }
    
    
    func testReponseAtRepository() {
           let jsonStub = [
                        "login" : "mojombo",
                        "url" : "https://api.github.com/users/mojombo",
                        "repos_url" : "https://api.github.com/users/mojombo/repos",
                        ] as [String : Any]

             stub(condition: isHost("api.github.com") && isPath("/users/mojombo"), response: { s in
                 print(s)
                 return OHHTTPStubsResponse(jsonObject: jsonStub, statusCode: 200, headers: .none)
             })
             
             let expectationResponse = expectation(description: "Get user from Git Hub API")
        
        
        UserRepository().fetchUsers { (users) in
            guard let loginAsString = jsonStub["login"] as? String else { XCTAssertTrue(false)
                               return}

            guard let urlAsString = jsonStub["url"] as? String else {XCTAssertTrue(false)
                return}

            guard let repoUrlAsString = jsonStub["repos_url"] as? String else {XCTAssertTrue(false)
                return}
            
            XCTAssertEqual(users[0].userName, loginAsString)
                         XCTAssertEqual(users[0].userUrl, urlAsString)
                         XCTAssertEqual(users[0].reposUrl, repoUrlAsString)
                         expectationResponse.fulfill()
            
        }
        self.waitForExpectations(timeout: 2.0, handler: .none)
        OHHTTPStubs.removeAllStubs()
    }
}
