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
            } else {
                
                XCTFail(response.error?.localizedDescription ?? "ERROR")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testAPIResponseTitle() {
        
        let exp = expectation(description: "Alamofire API Response")
        
        DataViewModel.objDataViewModel.refreshCollectionData { (done) in
            if done {
                
                let resultString = DataViewModel.objDataViewModel.title
                let expectedString = "About Canada"
                XCTAssertEqual(resultString, expectedString)
                exp.fulfill()
            } else {
                
                XCTFail("TITLE DOES NOT MATCH")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testAPIJSONResponse() {
        
        let exp = expectation(description: "API JSON Response")
        
        Alamofire.request(Constant.url) .validate().responseString { (response) in
            
            if response.result.isSuccess {
                guard let data = response.value?.data(using: .utf8) else { return }
                do {
                    //JSON data parsing using Codable protocol
                    let decoder = JSONDecoder()
                    let viewData = try decoder.decode(APIResponse.self, from: data)
                    
                    if let count = viewData.rows?.count, count > 0 {
                        
                        exp.fulfill()
                    } else {
                        
                        XCTFail("API DOES NOT CONTAIN ANY DATA TO DISPLAY ON COLLECTIONVIEW")
                    }
                    
                } catch let err {
                    
                    XCTFail(err.localizedDescription)
                }
            } else {
                
                XCTFail(response.error?.localizedDescription ?? "ERROR")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
