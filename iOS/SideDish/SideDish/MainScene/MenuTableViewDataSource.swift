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
        return dataManager[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as? MenuTableViewCell else { return UITableViewCell() }
        let sideDish = dataManager[indexPath.section][indexPath.row]
        guard cell.sideDish != sideDish else { return cell }
        cell.sideDish = sideDish
        SideDishUseCase.loadImage(url: sideDish.image) { data in
            DispatchQueue.main.async {
                cell.menuImage.image = UIImage(data: data)
            }
        }
        return cell
    }
}
