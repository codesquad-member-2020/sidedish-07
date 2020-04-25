//
//  MenuTableViewCell.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/21.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    static let reuseIdentifier = "menuCell"
    
    private(set) var hashCode = String()
    
    @IBOutlet weak var menuImage: UIImageView! {
        didSet {
            configureMenuImage()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLabel!
    @IBOutlet weak var eventBadgeStackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateCell(data: SideDish) {
        hashCode = data.hash
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        priceLabel.setPrice(sale: data.salePrice, normal: data.normalPrice)
        eventBadgeStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        if let badges = data.badges {
            badges.forEach {
                let badge = KeywordLabel()
                badge.setKeyword($0)
                eventBadgeStackView.addArrangedSubview(badge)
            }
        }
    }
    
    private func configureMenuImage() {
        menuImage.layer.cornerRadius = menuImage.frame.width / 2
    }
}
