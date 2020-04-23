//
//  DataManager.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/23.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class DataManager {
    enum Category: String {
        case main, soup, side
        
        var section: Int {
            switch self {
            case .main:
                return 0
            case .soup:
                return 1
            case .side:
                return 2
            }
        }
    }
    
    static let dataDidLoad = NSNotification.Name.init("dataDidLoad")
    
    private let serverUrl = "http://15.165.190.16/products/"
    private(set) var sectionDataList = [Int: [SideDish]]()

    func loadData() {
        load(category: .main)
        load(category: .soup)
        load(category: .side)
    }
    
    private func load(category: Category) {
        NetworkManager.httpRequest(url: serverUrl + category.rawValue, method: .GET) { (data, _, _) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(SideDishData.self, from: data)
                self.sectionDataList[category.section] = decodedData.content
                NotificationCenter.default.post(name: DataManager.dataDidLoad, object: nil)
            } catch {
                
            }
        }
    }
}
