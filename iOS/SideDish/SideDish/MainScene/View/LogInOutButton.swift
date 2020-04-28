//
//  LogInOutButton.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/29.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class LogInOutButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setProperties()
    }
    
    private func setProperties() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 58/255, green: 197/255, blue: 192/255, alpha: 1)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
}
