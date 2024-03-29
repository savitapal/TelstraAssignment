//
//  DataViewModel.swift
//  Assignment
//
//  Created by test on 29/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class DataViewModel {
    // MARK: - Variables
    
    static let objDataViewModel = DataViewModel()
    
    // Reqired data for the collectionview
    
    var dataArray = [RowData]()
    
    // Title for navigationbar
    
    var title: String?
    
    // MARK: - refesh the collectionview by calling API
    
    func refreshCollectionData(completionHandler: @escaping (Bool) -> Void) {
        
        NetworkManager.shared.getDataFromAPI { (data, error) in
            if error == nil {
                guard let apiData = data else {
                    return
                }
                if let title = apiData.title {
                    self.title = title
                    guard let viewRows = apiData.rows else { return }
                    // Check for nil values inside the array
                    
                    let array = viewRows.filter({ $0.title != nil || $0.description != nil || $0.imageHref != nil })
                    DataViewModel.objDataViewModel.dataArray = array
                    completionHandler(true)
                }
            } else {
                
                completionHandler(false)
            }
        }
    }
}
