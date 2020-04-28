//
//  DescriptionViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/21.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

protocol PresentingViewController {
    func orderSuccessAlert()
}

class DescriptionViewController: UIViewController {
    static let identifier = "description"
    
    var delegate: PresentingViewController?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var previewScrollView: PreviewScrollView!
    @IBOutlet weak var detailImageStack: DetailImageStack!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateData(hash: String) {
        SideDishUseCase.loadDetail(hash: hash) {
            self.updateView(data: $0)
        }
    }
    
    private func updateView(data: DetailSideDish) {
        DispatchQueue.main.async {
            self.titleLabel.text = data.title
            self.descriptionLabel.text = data.description
            self.priceLabel.setPrice(sale: data.salePrice, normal: data.normalPrice)
            self.deliveryFeeLabel.text = data.deliveryFee
            self.deliveryInfoLabel.text = data.deliveryInfo
        }
        data.thumbImages.forEach { imageURL in
            SideDishUseCase.loadImage(url: imageURL) { imageData in
                guard let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    self.previewScrollView.addImageSubview(image: image)
                }
            }
        }
        data.detailImages.forEach { imageURL in
            SideDishUseCase.loadImage(url: imageURL) { imageData in
                guard let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    self.detailImageStack.addImageSubview(image: image)
                }
            }
        }
    }
    
    @IBAction func orderButtonTabbed(_ sender: Any) {
        if SideDishUseCase.token == nil {
            let alert = UIAlertController(title: "비회원은 주문이 불가능합니다.", message: "로그인이 필요합니다.", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "로그인", style: .default) { _ in
                guard let webViewController = self.storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) else { return }
                self.present(webViewController, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "닫기", style: .default, handler: nil)
            alert.addAction(loginAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
            delegate?.orderSuccessAlert()
        }
    }
}
