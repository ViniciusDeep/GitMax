//
//  InsideUserTests.swift
//  ios-recruitmentTests
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import ios_recruitment

class InsideUserTests: XCTestCase {
    
    var repositorieStub = Repositorie()
    
    
    let insideUserViewModelStub: InsideUserViewModel = InsideUserViewModel(user: User())
    var insideUserRepoCellViewModelStub: InsideUserRepoCellViewModel?
    
    func testRequestReponse() {
        let jsonStub = [
                   "login" : "mojombo",
                   "url" : "https://api.github.com/users/mojombo",
                   "repos_url" : "https://api.github.com/users/mojombo/repos",
                   ] as [String : Any]
        
        stub(condition: isHost("api.github.com") && isPath("/users/mojombo"), response: { s in
            print(s)
            return OHHTTPStubsResponse(jsonObject: jsonStub, statusCode: 200, headers: .none)
        })
        
        let expectationResponse = expectation(description: "Get all users from Git Hub API")
        
        
        Providey<[User]>().request(router: .users, withMethod: .get, params: nil) { (result) in
            switch result {
            case .success(let users):
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
                
                case .failure(let error):
                      print(error)
                      XCTAssertNotNil(error)
                
            }
        }
        
        self.waitForExpectations(timeout: 2.0, handler: .none)
        OHHTTPStubs.removeAllStubs()
    }
    
    func testinsideUserViewModel() {
        repositorieStub.language = "Swift"
        repositorieStub.name = "Then"
        repositorieStub.starsCount = 0
        repositorieStub.description = "Swift stub"
        
        insideUserRepoCellViewModelStub = InsideUserRepoCellViewModel(repositorieStub)
        
        
        
        XCTAssertEqual(repositorieStub.language, insideUserRepoCellViewModelStub?.repo?.language)
        XCTAssertEqual(repositorieStub.name, insideUserRepoCellViewModelStub?.repo?.name)
        XCTAssertEqual(repositorieStub.starsCount, insideUserRepoCellViewModelStub?.repo?.starsCount)
        XCTAssertEqual(repositorieStub.description, insideUserRepoCellViewModelStub?.repo?.description)
        
        insideUserViewModelStub.repoCellViewModels.append(insideUserRepoCellViewModelStub ?? InsideUserRepoCellViewModel(Repositorie()))
        
        XCTAssertEqual(insideUserViewModelStub.cellViewModel(forIndex: 0).repo?.name, insideUserRepoCellViewModelStub?.repo?.name)
        
        XCTAssertEqual(insideUserViewModelStub.numberOfRepos(), 1)
    }
    // Unit test to request
    func testGeneralRequestMethod() {
         Providey<[User]>().request(router: .users, withMethod: .get, params: nil) { (result) in
            switch result {
            case .success(let users):
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
                
                case .failure(let error):
                      print(error)
                      XCTAssertNotNil(error)
                
            }
    } 
    // Test future response
    func testGeneralResponse() {
         Providey<[User]>().request(router: .users, withMethod: .get, params: nil) { (result) in
            switch result {
            case .success(let users):
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
                
                case .failure(let error):
                      print(error)
                      XCTAssertNotNil(error)
                
            }
    }        
}
