//
//  PreviewScrollView.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/28.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class PreviewScrollView: UIScrollView {
    @IBOutlet weak var stackView: UIStackView!
    
    func addImageSubview(image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor).isActive = true
    }
}
