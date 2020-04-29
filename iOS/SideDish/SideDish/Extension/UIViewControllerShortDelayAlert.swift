//
//  UIViewControllerShortDelayAlert.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/29.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

extension UIViewController {
    func shortDelayAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
