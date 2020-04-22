//
//  ViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    
    var data: [SideDish]?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.register(MenuSectionHeader.self, forHeaderFooterViewReuseIdentifier: MenuSectionHeader.reuseIdentifier)
        
        NetworkManager.httpRequest(url: NetworkManager.serverUrl + "main", method: .GET) { (data, _, _) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(SideDishData.self, from: data)
                self.data = decodedData.body
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
                }
            } catch {
                
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as? MenuTableViewCell,
            let data = data else { return UITableViewCell() }
        let sideDish = data[indexPath.row]
        do {
            let imageData = try Data(contentsOf: sideDish.image)
            cell.menuImage.image = UIImage(data: imageData)
        } catch {
            print(error)
        }
        cell.titleLabel.text = sideDish.title
        cell.descriptionLabel.text = sideDish.description
        cell.priceLabel.text = sideDish.s_price
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuSectionHeader.reuseIdentifier) as? MenuSectionHeader else { return nil }
        
        header.keywordLabel.text = "밑반찬"
        header.sectionTitle.text = "언제 먹어도 든든한 밑반찬"
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MenuSectionHeader.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let descriptionViewController = storyboard?.instantiateViewController(withIdentifier: DescriptionViewController.identifier) as? DescriptionViewController else { return }
        navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}
