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
    @IBOutlet weak var priceLabel: UILabel!
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
        titleLabel.text = sideDish?.title
        descriptionLabel.text = sideDish?.description
        priceLabel.text = sideDish?.s_price
        if let badges = sideDish?.badge {
            badges.forEach {
                let badge = KeywordLabel()
                badge.text = $0
                eventBadgeStackView.addArrangedSubview(badge)
            }
        }
    }
}
