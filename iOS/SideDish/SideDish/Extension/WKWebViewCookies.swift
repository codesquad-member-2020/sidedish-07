//
//  WKWebViewCookies.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/28.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import WebKit

extension WKWebView {
    private var dataStore: WKWebsiteDataStore  {
        return WKWebsiteDataStore.default()
    }
    
    func cleanAllCookies() {
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                self.dataStore.removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    func getAuthorization(for domain: String? = nil, completion: @escaping (HTTPCookie)->())  {
        dataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if cookie.name == "Authorization" {
                    completion(cookie)
                }
            }
        }
    }
}
