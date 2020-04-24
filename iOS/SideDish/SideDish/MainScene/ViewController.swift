//
//  ViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let dataManager = DataManager()
    private var menuTableViewDataSource: MenuTableViewDataSource?
    
    @IBOutlet weak var menuTableView: UITableView!
        
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        menuTableViewDataSource = MenuTableViewDataSource(dataManager: dataManager)
        menuTableView.delegate = self
        menuTableView.dataSource = menuTableViewDataSource
        menuTableView.register(MenuSectionHeader.self, forHeaderFooterViewReuseIdentifier: MenuSectionHeader.reuseIdentifier)
        addObservers()
        configureUseCase()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection(_:)), name: DataManager.reloadSection, object: nil)
    }
    
    private func configureUseCase() {
        SideDishUseCase.loadAll { (section, list) in
            DispatchQueue.main.async {
                self.dataManager.updateData(section: section, data: list)
            }
        }
    }
    
    @objc private func reloadSection(_ notification: NSNotification) {
        guard let section = notification.userInfo?[DataManager.reloadSection] as? Int else { return }
        self.menuTableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuSectionHeader.reuseIdentifier) as? MenuSectionHeader else { return nil }
        header.keywordLabel.text = dataManager.keywordList[section]
        header.sectionTitle.text = dataManager.titleList[section]
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
