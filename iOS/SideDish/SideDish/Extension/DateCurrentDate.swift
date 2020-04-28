//
//  DateCurrentDate.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/29.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

extension Date {
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분"
        return formatter.string(from:Date())
    }
}
