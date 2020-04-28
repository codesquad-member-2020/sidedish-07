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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    
    @IBOutlet weak var previewScrollView: UIScrollView!
    @IBOutlet weak var thumbImageStack: UIStackView!
    @IBOutlet weak var detailImageStack: UIStackView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateData(hash: String) {
        SideDishUseCase.loadDetail(hash: hash) {
            let detailData = $0
            DispatchQueue.main.async {
                self.titleLabel.text = detailData.title
                self.descriptionLabel.text = detailData.description
                self.priceLabel.setPrice(sale: detailData.salePrice, normal: detailData.normalPrice)
                self.deliveryFeeLabel.text = detailData.deliveryFee
                self.deliveryInfoLabel.text = detailData.deliveryInfo
            }
            
            $0.thumbImages.forEach({
                let url = $0
                SideDishUseCase.loadImage(url: url) {
                    guard let image = UIImage(data: $0) else { return }
                    DispatchQueue.main.async {
                        let imageView = UIImageView()
                        imageView.image = image
                        imageView.translatesAutoresizingMaskIntoConstraints = false
                        self.thumbImageStack.addArrangedSubview(imageView)
                        imageView.widthAnchor.constraint(equalTo: self.previewScrollView.frameLayoutGuide.widthAnchor).isActive = true
                    }
                }
            })
            $0.detailImages.forEach({
                let url = $0
                SideDishUseCase.loadImage(url: url) {
                    guard let image = UIImage(data: $0) else { return }
                    
                    DispatchQueue.main.async {
                        let imageView = UIImageView()
                        imageView.image = image
                        imageView.contentMode = .scaleAspectFit
                        if let imageSize = imageView.image?.size, imageSize.height != 0 {
                            let aspectRatio = imageSize.width / imageSize.height
                            let c = NSLayoutConstraint(item: imageView, attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: imageView, attribute: .height,
                                                       multiplier: aspectRatio, constant: 0)
                            imageView.addConstraint(c)
                        }
                        self.detailImageStack.addArrangedSubview(imageView)
                    }
                }
            })
        }
    }
}
