//
//  githubAPITests.swift
//  githubAPITests
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import XCTest
@testable import githubAPI

class githubAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchRepositoriesByManager() {
        let expect = expectation(description: "Fetching repositories should succeeed")
        
        _ = ViewModel(accountName: "isidar") { repositories in
            XCTAssert(repositories.count >= 3)
            print(repositories.count)
            
            let neededRepositoriesExist = repositories.contains {
                switch ($0.name ?? "") {
                case "calculatorRepository", "discountCardManager", "githubAPI":
                    return true
                default:
                    return false
                }
            }
            XCTAssert(neededRepositoriesExist, "Array of repositories hasn't all required items")
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            XCTAssertNil(error, "Test timed out. \(error?.localizedDescription ?? "")")
        }
    }
    
    func testSortingOfRepositories() {
        let expect = expectation(description: "Fetching repositories should succeeed")
        
        let viewModel = ViewModel(accountName: "isidar") { _ in
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            XCTAssertNil(error, "Test timed out. \(error?.localizedDescription ?? "")")
        }
        
        let sortedRepositories = viewModel.repositories
        
        XCTAssert(
            sortedRepositories[0].name == "calculatorRepository" &&
                sortedRepositories[1].name == "discountCardManager" &&
                sortedRepositories[2].name == "githubAPI",
            "Array of repositories is not 'a-z' sorted"
        )
    }
    
    func testFetchedRepositoriesData() {
        let expect = expectation(description: "Fetching repositories should succeeed")
        
        _ = ViewModel(accountName: "CocoaPods") { repositories in
            if let cocoaPodsIndex = repositories.firstIndex(where: { $0.name == "CocoaPods" }) {
                let cocoaPodsRepository = repositories[cocoaPodsIndex]
                
                XCTAssert(cocoaPodsRepository.URL == "https://github.com/CocoaPods/CocoaPods")
                XCTAssertFalse(cocoaPodsRepository.tags?.isEmpty == true)
                XCTAssertNotNil(cocoaPodsRepository.tags?.firstIndex(of: "swift"))
            } else { XCTAssertNotNil(nil, "There is no 'CocoaPods' repository") }
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            XCTAssertNil(error, "Test timed out. \(error?.localizedDescription ?? "")")
        }
    }
    
    func testTwoTimesFetching() {
        let cocoaPodsExpect = expectation(description: "Fetching 'CocoaPods' repositories should succeeed")
        let isidarExpect = expectation(description: "Fetching 'isidar' repositories should succeeed")
        
        // fetching data from 'CocoaPods'
        let viewModel = ViewModel(accountName: "CocoaPods") { repositories in
            let cocoaPodsIndex = repositories.firstIndex(where: { $0.name == "CocoaPods" })
    
            XCTAssertNotNil(cocoaPodsIndex, "There is no 'CocoaPods' repository. Fetching has failed")
            
            cocoaPodsExpect.fulfill()
        }
        wait(for: [cocoaPodsExpect], timeout: 20)
        
        // fetching data from 'isidar'
        viewModel.fetchRepositories(fromAccount: "isidar") { repositories in
            let githubAPIIndex = repositories.firstIndex(where: { $0.name == "githubAPI" })
            
            XCTAssertNotNil(githubAPIIndex, "There is no 'githubAPI' repository. Fetching has failed")
            
            isidarExpect.fulfill()
        }
        wait(for: [isidarExpect], timeout: 20)
    }
    
}
