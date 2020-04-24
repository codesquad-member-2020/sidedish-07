//
//  SideDishUseCase.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/25.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

struct SideDishUseCase {
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
    
    static let loadFailed = NSNotification.Name.init("loadFailed")
    static let serverUrl = "http://15.165.190.16/products/"
    
    static func loadAll(completed: @escaping (Int, [SideDish]) -> ()) {
        loadList(category: .main, completed: completed)
        loadList(category: .soup, completed: completed)
        loadList(category: .side, completed: completed)
    }
    
    static func loadList(category: Category, completed: @escaping (Int, [SideDish]) -> ()) {
        NetworkManager.httpRequest(url: serverUrl + category.rawValue, method: .GET, completionHandler: { (data, _, error) in
            guard let data = data else {
                NotificationCenter.default.post(name: loadFailed, object: nil)
                return
            }
            let list = try? JSONDecoder().decode(SideDishData.self, from: data).content
            completed(category.section, list ?? [])
        })
    }
}
