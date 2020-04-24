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
    
    static let serverUrl = "http://15.165.190.16/products/"
    
    static func loadList(category: Category, completed: @escaping (Int, [SideDish]) -> ()) {
        try? NetworkManager.httpRequest(url: serverUrl + category.rawValue, method: .GET, completionHandler: { (data, _, error) in
            guard let data = data else { return }
            let list = try? JSONDecoder().decode(SideDishData.self, from: data).content
            completed(category.section, list ?? [])
        })
    }
}
