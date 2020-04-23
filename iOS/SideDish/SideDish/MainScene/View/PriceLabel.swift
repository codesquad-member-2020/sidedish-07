//
//  PriceLabel.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/23.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class PriceLabel: UILabel {
    func setPrice(sale: String?, normal: String) {
        guard let sale = sale else {
            self.text = normal
            return
        }
        let string = "\(sale) \(normal)"
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttributes([NSAttributedString.Key.baselineOffset: 0,
                                        NSAttributedString.Key.strikethroughStyle: 1,
                                        NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                                        .font: UIFont.systemFont(ofSize: 10.0)],
                                       range: (string as NSString).range(of: sale))
        self.attributedText = attributedString
    }
}
