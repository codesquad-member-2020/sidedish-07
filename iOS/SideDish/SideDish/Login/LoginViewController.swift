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
        present(mainVC, animated: true, completion: nil)
    }
}
