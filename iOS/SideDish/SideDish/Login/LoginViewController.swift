//
//  LoginViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/28.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nonMemberLoginButtonTabbed(_ sender: Any) {
        guard let mainVC = storyboard?.instantiateViewController(identifier: MainViewController.navigationControllerIdentifier) else { return }
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
    @IBAction func loginWithGitHubButtonTabbed(_ sender: Any) {
        guard let webVC = storyboard?.instantiateViewController(identifier: WebViewController.identifier) as? WebViewController else { return }
        webVC.delegate = self
        present(webVC, animated: true, completion: nil)
    }
}

extension LoginViewController: WebViewControllerDelegate {
    func loginCompeleted() {
        guard let mainVC = storyboard?.instantiateViewController(identifier: MainViewController.navigationControllerIdentifier) else { return }
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true) {
            let alert = UIAlertController(title: "로그인 성공!", message: "환영합니다", preferredStyle: .alert)
            mainVC.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
