//
//  NetworkManager.swift
//  Assignment
//
//  Created by test on 29/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    // MARK: - Variables
    
    static let shared = NetworkManager()
    
    // specifying init method as private, so that other instance of this class will not be created
    
    private init() {}
    
    // MARK: - API call method
    
    func getDataFromAPI(completionHandler: @escaping (APIResponse?, _ error: Error?) -> Void) {
        
        Alamofire.request(Constant.url) .validate().responseString { (response) in
            if response.result.isSuccess {
                guard let data = response.value?.data(using: .utf8) else { return }
                do {
                    // JSON data parsing using Codable protocol
                    
                    let decoder = JSONDecoder()
                    let viewData = try decoder.decode(APIResponse.self, from: data)
                    completionHandler(viewData, nil)
                } catch let err {
                    completionHandler(nil, err)
                }
            }
        }
    }
}
