//
//  ViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var dataManager = DataManager()
    
    @IBOutlet weak var menuTableView: UITableView!
        
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(MenuSectionHeader.self, forHeaderFooterViewReuseIdentifier: MenuSectionHeader.reuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: DataManager.dataDidLoad, object: nil)
        
        dataManager.loadData()
    }
    
    @objc func reloadTableView() {
        DispatchQueue.main.async {
            self.menuTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataManager.sectionDataList[section] else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as? MenuTableViewCell,
            let data = dataManager.sectionDataList[indexPath.section] else { return UITableViewCell() }
        let sideDish = data[indexPath.row]
        cell.eventBadgeStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        cell.sideDish = sideDish
        NetworkManager.httpRequest(url: sideDish.image, method: .GET) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                cell.menuImage.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuSectionHeader.reuseIdentifier) as? MenuSectionHeader else { return nil }
        let keywordList = [0: "메인반찬",
                           1: "국∙찌개",
                           2: "밑반찬"]
        let titleList = [0: "한그릇 뚝딱 메인 요리",
                         1: "김이 모락모락 국∙찌개",
                         2: "언제 먹어도 든든한 밑반찬"]
        header.keywordLabel.text = keywordList[section]
        header.sectionTitle.text = titleList[section]
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.sectionDataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MenuSectionHeader.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let descriptionViewController = storyboard?.instantiateViewController(withIdentifier: DescriptionViewController.identifier) as? DescriptionViewController else { return }
        navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}
