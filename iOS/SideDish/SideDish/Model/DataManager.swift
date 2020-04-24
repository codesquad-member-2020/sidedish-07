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
    
    private(set) var keywordList = [0: "메인반찬",
                       1: "국∙찌개",
                       2: "밑반찬"]
    private(set) var titleList = [0: "한그릇 뚝딱 메인 요리",
                     1: "김이 모락모락 국∙찌개",
                     2: "언제 먹어도 든든한 밑반찬"]
    private var sectionDataList = [Int: [SideDish]]()
    
    func updateData(section: Int, data: [SideDish]) {
        sectionDataList[section] = data
        NotificationCenter.default.post(name: DataManager.reloadSection, object: nil, userInfo: [DataManager.reloadSection: section])
    }
    
    func sideDishes(at section: Int) -> [SideDish] {
        return sectionDataList[section] ?? []
    }
}
