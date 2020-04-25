//
//  KeywordLabel.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class KeywordLabel: UILabel {
    static var keywordList = [String: UIColor]()

    private let padding = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    private let colors = [UIColor.systemIndigo,
                          UIColor.systemPurple,
                          UIColor.systemOrange]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    func setKeyword(_ keyword: String) {
        if KeywordLabel.keywordList[keyword] == nil {
            KeywordLabel.keywordList[keyword] = colors[KeywordLabel.keywordList.count]
        }
        layer.borderColor = KeywordLabel.keywordList[keyword]?.cgColor
        backgroundColor = KeywordLabel.keywordList[keyword]
        text = keyword
        textColor = .white
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 0.8
        font = UIFont.boldSystemFont(ofSize: 10.0)
        textAlignment = .center
        textColor = .gray
        layer.borderColor = UIColor.gray.cgColor
    }
}
