//
//  WebViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/27.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    private let loginURL = "https://github.com/login/oauth/authorize?client_id=71186054709e9adda0f9&scope=user:email&redirect_uri=http://15.164.63.83:8080/login"
    private let successResopnse = "http://15.164.63.83:8080/"
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.cleanAllCookies()
        guard let url = URL(string: loginURL) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
            "\(url)" == successResopnse else {
                decisionHandler(.allow)
                return
        }
        guard let mainVC = storyboard?.instantiateViewController(identifier: MainViewController.navigationControllerIdentifier) else { return }
        decisionHandler(.cancel)
        webView.getAuthorization {
            print($0.value)
        }
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
}


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

