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
    
    var sideDish: SideDish? {
        didSet {
            updateCell()
        }
    }
    
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
    
    private func configureMenuImage() {
        menuImage.layer.cornerRadius = menuImage.frame.width / 2
    }
    
    private func updateCell() {
        guard let sideDish = sideDish else { return }
        titleLabel.text = sideDish.title
        descriptionLabel.text = sideDish.description
        priceLabel.setPrice(sale: sideDish.salePrice, normal: sideDish.normalPrice)
        eventBadgeStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        if let badges = sideDish.badges {
            badges.forEach {
                let badge = KeywordLabel()
                badge.setKeyword($0)
                eventBadgeStackView.addArrangedSubview(badge)
            }
        }
    }
}
