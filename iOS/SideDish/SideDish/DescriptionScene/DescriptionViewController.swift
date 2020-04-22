//
//  DescriptionViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/21.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    static let identifier = "description"
    
    @IBOutlet weak var previewScrollView: UIScrollView!
    @IBOutlet weak var thumbImageStack: UIStackView!
    
    var thumbImages = ["scroll1",
                       "scroll2",
                       "scroll3",
                       "scroll4"]
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for image in thumbImages {
            let imageView = UIImageView()
            imageView.image = UIImage(named: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            thumbImageStack.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: previewScrollView.frameLayoutGuide.widthAnchor).isActive = true
        }
    }
}
