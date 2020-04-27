//
//  WebViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/27.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    private let loginURL = "https://github.com/login?client_id=71186054709e9adda0f9&return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3D71186054709e9adda0f9%26redirect_uri%3Dhttp%253A%252F%252F15.164.63.83%253A8080%252Flogin%252Foauth2%252Fcode%252Fgithub%26scope%3Duser%253Aemail"
    private let successResopnse = "http://15.164.63.83:8080/login/oauth2/code/"
    
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
        guard "\(navigationAction.request.url!)".contains(successResopnse) else {
            decisionHandler(.allow)
            return
        }
        guard let mainVC = storyboard?.instantiateViewController(identifier: MainViewController.navigationControllerIdentifier) else { return }
        decisionHandler(.cancel)
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
}


extension WKWebView {
    func cleanAllCookies() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}
