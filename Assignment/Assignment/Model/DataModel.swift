//
//  DataModel.swift
//  Assignment
//
//  Created by test on 29/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
    
    var title: String?
    var rows: [RowData]?
}

struct RowData: Codable {
    
    var title: String?
    var description: String?
    var imageHref: String?
}
