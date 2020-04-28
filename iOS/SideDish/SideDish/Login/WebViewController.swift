//
//  WebViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/27.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import WebKit

protocol WebViewControllerDelegate {
    func loginCompeleted()
}

class WebViewController: UIViewController {
    static let identifier = "web"
    
    private let loginURL = "https://github.com/login/oauth/authorize?client_id=71186054709e9adda0f9&scope=user:email&redirect_uri=http://15.165.65.200/login"
    private let successResopnse = "http://15.165.65.200/"
    var delegate: WebViewControllerDelegate?
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.cleanAllCookies()
        guard let url = URL(string: loginURL) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
            "\(url)" == successResopnse else {
                decisionHandler(.allow)
                return
        }
        decisionHandler(.cancel)
        webView.getAuthorization {
            SideDishUseCase.token = $0.value
        }
        dismiss(animated: true) {
            self.delegate?.loginCompeleted()
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.isHidden = true
        indicator.stopAnimating()
    }
}
