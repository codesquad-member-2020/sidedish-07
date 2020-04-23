//
//  KeywordLabel.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class KeywordLabel: UILabel {
    private let padding = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    
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
        let keywordList = ["이벤트특가": UIColor.purple,
                           "론칭특가": UIColor.purple,
                           "품절": UIColor.black,
                           "사은품증정": UIColor.orange]
        layer.borderColor = keywordList[keyword]?.cgColor
        backgroundColor = keywordList[keyword]
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
