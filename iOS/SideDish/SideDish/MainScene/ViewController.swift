//
//  ViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var menuTableViewDataSource = MenuTableViewDataSource()
    
    @IBOutlet weak var menuTableView: UITableView!
        
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        menuTableView.delegate = self
        menuTableView.dataSource = menuTableViewDataSource
        menuTableView.register(MenuSectionHeader.self, forHeaderFooterViewReuseIdentifier: MenuSectionHeader.reuseIdentifier)
        SideDishUseCase.loadList(category: .main) { (section, list) in
            DispatchQueue.main.async {
                self.menuTableViewDataSource.sectionDataList[section] = list
                self.menuTableView.reloadSections(IndexSet(integer: section), with: .automatic)
            }
        }
        SideDishUseCase.loadList(category: .side) { (section, list) in
            DispatchQueue.main.async {
                self.menuTableViewDataSource.sectionDataList[section] = list
                self.menuTableView.reloadSections(IndexSet(integer: section), with: .automatic)
            }
        }
        SideDishUseCase.loadList(category: .soup) { (section, list) in
            DispatchQueue.main.async {
                self.menuTableViewDataSource.sectionDataList[section] = list
                self.menuTableView.reloadSections(IndexSet(integer: section), with: .automatic)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MenuSectionHeader.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let descriptionViewController = storyboard?.instantiateViewController(withIdentifier: DescriptionViewController.identifier) as? DescriptionViewController else { return }
        navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}
