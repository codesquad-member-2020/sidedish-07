//
//  NetworkManager.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/22.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class NetworkManager {
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    static let session = URLSession.shared
    
    static func httpRequest(url: String, method: HTTPMethod, body: Data? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        if body != nil {
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        request.httpMethod = method.rawValue
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    static func httpRequestWith(token: String?, url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let token = token {
            request.setValue("Authorization=\(token)", forHTTPHeaderField: "Cookie")
        }
        request.httpShouldHandleCookies = true
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
