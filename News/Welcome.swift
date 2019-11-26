//
//  Welcome.swift
//  News
//
//  Created by Vasilii on 26.11.2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import Foundation

struct Welcome: Decodable {
    let issues: [Issue]
}

struct Issue: Decodable {
    let url: String
    let dateIssued: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case dateIssued = "date_issued"
    }
    
    init(url: String, dateIssued: String) {
        self.url = url
        self.dateIssued = dateIssued
    }
}
