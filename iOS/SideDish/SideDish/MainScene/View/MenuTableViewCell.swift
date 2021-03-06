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

    @IBOutlet weak var menuImage: UIImageView! {
        didSet {
            configureMenuImage()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLabel!
    @IBOutlet weak var eventBadgeStackView: BadgeStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateCell(data: SideDish) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        priceLabel.setPrice(sale: data.salePrice, normal: data.normalPrice)
        eventBadgeStackView.updateBadges(data.badges)
    }
    
    private func configureMenuImage() {
        menuImage.layer.cornerRadius = menuImage.frame.width / 2
    }
}
