//
//  MenuTableViewDataSource.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/23.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class MenuTableViewDataSource: NSObject, UITableViewDataSource {
    static let reloadCell = NSNotification.Name.init("reloadCell")
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as? MenuTableViewCell else { return UITableViewCell() }
        let sideDish = dataManager[indexPath.section][indexPath.row]
        cell.updateCell(data: sideDish)
        guard let image = ImageFileManager.getSavedImage(name: sideDish.image.filterRegex(#"(.*(\/))"#)) else {
            NotificationCenter.default.post(name: MenuTableViewDataSource.reloadCell, object: nil, userInfo: [MenuTableViewDataSource.reloadCell: indexPath])
            return cell
        }
        DispatchQueue.main.async {
            cell.menuImage.image = image
        }
        return cell
    }
}
