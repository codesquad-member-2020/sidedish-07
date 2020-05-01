//
//  MainViewController.swift
//  SideDish
//
//  Created by TTOzzi on 2020/04/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit
import Toaster

class MainViewController: UIViewController {
    static let navigationControllerIdentifier = "main"
    
    private let dataManager = DataManager()
    private var menuTableViewDataSource: MenuTableViewDataSource?
    lazy var logInOutButton: LogInOutButton = {
        let button = LogInOutButton(frame: .zero)
        button.addTarget(self, action: #selector(logInOutButtonTabbed(_:)), for: .touchUpInside)
        return button
    }()
    
    @IBOutlet weak var menuTableView: UITableView!
        
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let view = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            view.addSubview(logInOutButton)
            setupButton()
        }
    }
    
    override func viewDidLoad() {
        menuTableViewDataSource = MenuTableViewDataSource(dataManager: dataManager)
        menuTableView.delegate = self
        menuTableView.dataSource = menuTableViewDataSource
        menuTableView.register(MenuSectionHeader.self, forHeaderFooterViewReuseIdentifier: MenuSectionHeader.reuseIdentifier)
        addObservers()
        configureUseCase()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if UIApplication.shared.windows.filter({$0.isKeyWindow}).first != nil {
            logInOutButton.removeFromSuperview()
        }
    }
    
    func setupButton() {
        if SideDishUseCase.token == nil {
            logInOutButton.setTitle("LogIn", for: .normal)
        } else {
            logInOutButton.setTitle("LogOut", for: .normal)
        }
        NSLayoutConstraint.activate([
            logInOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logInOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            logInOutButton.heightAnchor.constraint(equalToConstant: 40),
            logInOutButton.widthAnchor.constraint(equalToConstant: 80)
            ])
    }

    @objc func logInOutButtonTabbed(_ button: UIButton) {
        if SideDishUseCase.token == nil {
            guard let webViewController = storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController else { return }
            webViewController.delegate = self
            present(webViewController, animated: true, completion: nil)
        } else {
            SideDishUseCase.token = nil
            logInOutButton.setTitle("LogIn", for: .normal)
            shortDelayAlert(title: "로그아웃!", message: "로그아웃 되었습니다.")
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert(_:)), name: SideDishUseCase.loadFailed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection(_:)), name: DataManager.reloadSection, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCell(_:)), name: MenuTableViewDataSource.reloadCell, object: nil)
    }
    
    private func configureUseCase() {
        SideDishUseCase.loadAll { (section, list) in
            list.forEach {
                let imageName = $0.image.filterRegex(#"(.*(\/))"#)
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
    
    @objc private func sectionHeaderTapped(_ sender: UITapGestureRecognizer) {
        guard let sectionHeader = sender.view as? MenuSectionHeader,
            let section = sectionHeader.section,
            let sectionTitle = dataManager.titleList[section] else { return }
        Toast(text: "\(sectionTitle) \(dataManager[section].count)개").show()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuSectionHeader.reuseIdentifier) as? MenuSectionHeader else { return nil }
        header.keywordLabel.text = dataManager.keywordList[section]
        header.sectionTitle.text = dataManager.titleList[section]
        header.section = section
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped(_:)))
        header.addGestureRecognizer(recognizer)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MenuSectionHeader.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let descriptionViewController = storyboard?.instantiateViewController(withIdentifier: DescriptionViewController.identifier) as? DescriptionViewController else { return }
        descriptionViewController.updateData(hash: dataManager[indexPath.section][indexPath.row].hash)
        descriptionViewController.delegate = self
        navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}

extension MainViewController: PresentingViewController {
    func orderSuccessAlert(menuName: String, date: String) {
        let alert = UIAlertController(title: "주문 성공!", message: "상품명: \(menuName)\n주문일자: \(date)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension MainViewController: WebViewControllerDelegate {
    func loginCompeleted() {
        logInOutButton.setTitle("LogOut", for: .normal)
        shortDelayAlert(title: "로그인 성공!", message: "환영합니다.")
    }
}
