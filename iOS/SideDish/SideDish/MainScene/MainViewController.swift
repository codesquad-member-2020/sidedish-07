//
//  MainViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    static let navigationControllerIdentifier = "main"
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert(_:)), name: SideDishUseCase.loadFailed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection(_:)), name: DataManager.reloadSection, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCell(_:)), name: MenuTableViewDataSource.reloadCell, object: nil)
    }
    
    private func configureUseCase() {
        SideDishUseCase.loadAll { (section, list) in
            list.forEach {
                let imageName = $0.hash
                SideDishUseCase.loadImage(url: $0.image) {
                    guard let image = UIImage(data: $0) else { return }
                    ImageFileManager.saveImage(image: image, name: imageName)
                }
            }
            DispatchQueue.main.async {
                self.dataManager.updateData(section: section, data: list)
            }
        }
    }
    
    @objc private func errorAlert(_ notification: NSNotification) {
        guard let title = notification.userInfo?["title"] as? String,
            let message = notification.userInfo?["message"] as? String else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    @objc private func reloadSection(_ notification: NSNotification) {
        guard let section = notification.userInfo?[DataManager.reloadSection] as? Int else { return }
        self.menuTableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    @objc private func reloadCell(_ notification: NSNotification) {
        guard let indexPath = notification.userInfo?[MenuTableViewDataSource.reloadCell] as? IndexPath else { return }
        DispatchQueue.main.async {
            self.menuTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension MainViewController: UITableViewDelegate {
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
