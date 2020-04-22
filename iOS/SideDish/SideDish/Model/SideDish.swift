//
//  SideDish.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/22.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

struct SideDishData {
    var body: [SideDish]
}

struct SideDish {
    var detail_hash: String
    var image: String
    var title: String
    var description: String
    var n_price: String?
    var s_price: String
    var badge: [String]?
}
