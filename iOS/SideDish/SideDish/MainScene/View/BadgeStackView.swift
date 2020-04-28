//
//  BadgeStackView.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/28.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class BadgeStackView: UIStackView {
    func updateBadges(_ badges: [String]?) {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        guard let badges = badges else { return }
        badges.forEach {
            let badge = KeywordLabel()
            badge.setKeyword($0)
            addArrangedSubview(badge)
        }
    }
}
