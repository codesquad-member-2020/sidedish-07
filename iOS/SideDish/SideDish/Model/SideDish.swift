//
//  SideDish.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/22.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

struct SideDishData: Codable {
    var body: [SideDish]
}

struct SideDish: Codable {
    var detail_hash: String
    var image: URL
    var title: String
    var description: String
    var n_price: String?
    var s_price: String
    var badge: [String]?
}