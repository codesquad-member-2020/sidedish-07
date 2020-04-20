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
    
    override func viewDidLoad() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.register(MenuSectionHeader.self, forHeaderFooterViewReuseIdentifier: MenuSectionHeader.reuseIdentifier)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            MenuSectionHeader.reuseIdentifier) as! MenuSectionHeader
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
}
