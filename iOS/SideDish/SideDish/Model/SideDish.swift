//
//  SideDish.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/22.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

struct SideDishData: Codable {
    var content: [SideDish]
}

struct SideDish: Codable, Equatable {
    var hash: String
    var image: String
    var title: String
    var description: String
    var salePrice: String
    var normalPrice: String
    var badges: [String]?
}
