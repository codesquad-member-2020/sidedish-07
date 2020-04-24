//
//  DataManager.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/23.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class DataManager {
    static let reloadSection = NSNotification.Name.init("reloadSection")
    
    private var sectionDataList = [Int: [SideDish]]()
    
    func updateData(section: Int, data: [SideDish]) {
        sectionDataList[section] = data
        NotificationCenter.default.post(name: DataManager.reloadSection, object: nil, userInfo: [DataManager.reloadSection: section])
    }
    
    func sideDishes(at section: Int) -> [SideDish] {
        return sectionDataList[section] ?? []
    }
}
