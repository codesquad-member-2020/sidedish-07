//
//  MenuTableViewDataSource.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/23.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class MenuTableViewDataSource: NSObject, UITableViewDataSource {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataManager.sectionDataList[section] else { return 8 }
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return dataManager.sectionDataList.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as? MenuTableViewCell,
            let data = dataManager.sectionDataList[indexPath.section] else { return UITableViewCell() }
        let sideDish = data[indexPath.row]
        cell.sideDish = sideDish
        NetworkManager.httpRequest(url: sideDish.image, method: .GET) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                cell.menuImage.image = UIImage(data: data)
            }
        }
        return cell
    }
}
