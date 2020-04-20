//
//  MenuSectionHeader.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class MenuSectionHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "menuSectionHeader"
    static let height: CGFloat = 60
    
    let keywordLabel = KeywordLabel()
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(keywordLabel)
        contentView.addSubview(sectionTitle)
        
        NSLayoutConstraint.activate([
            keywordLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            keywordLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sectionTitle.topAnchor.constraint(equalTo: keywordLabel.bottomAnchor, constant: 5.0),
            sectionTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sectionTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }
}
