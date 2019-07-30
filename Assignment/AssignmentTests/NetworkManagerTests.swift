//
//  NetworkManagerTests.swift
//  AssignmentTests
//
//  Created by test on 30/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import Assignment
import Alamofire

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testAPIStatusCode() {
        
        let exp = expectation(description: "API Response Status Code")

        Alamofire.request(Constant.url) .validate().responseString { (response) in
            
            if response.response?.statusCode == 200 {
                
                exp.fulfill()
            }
            else {
                
                XCTFail(response.error?.localizedDescription ?? "ERROR")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testAPIResponse() {
        
        let exp = expectation(description: "Alamofire API Response")

        DataViewModel.objDataViewModel.refreshCollectionData { (done) in
            if done {
                
                let resultString = DataViewModel.objDataViewModel.title
                let expectedString = "About Canada"
                XCTAssertEqual(resultString, expectedString)
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
