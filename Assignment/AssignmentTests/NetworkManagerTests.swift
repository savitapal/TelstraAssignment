//
//  NetworkManagerTests.swift
//  AssignmentTests
//
//  Created by test on 30/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import Assignment

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testAPIResponse() {
        
        let e = expectation(description: "Alamofire")

        DataViewModel.objDataViewModel.refreshCollectionData { (done) in
            if done {
                
                let resultString = DataViewModel.objDataViewModel.title
                let expectedString = "About Canada"
                XCTAssertEqual(resultString, expectedString)
            }
            
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
