//
//  ViewController.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/18.
//

import UIKit
import SwiftGifOrigin
import SideMenu

class HomeViewController: UIViewController {
    @IBOutlet weak var noyakuTableView: UITableView!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    
    @IBOutlet weak var txtDescriptionLabel: UILabel!
    @IBOutlet weak var btnAddPesticide: BGButton!
    
    // DEBUG
    var listData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeIsHiddenTableView()
        noyakuTableView.register(UINib(nibName: "PesticideCustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        setUpSideMenu()
    }
    
    private func changeIsHiddenTableView() {
        if listData.isEmpty {
            noyakuTableView.isHidden = true
            txtDescriptionLabel.isHidden = false
            btnAddPesticide.isHidden = false
        } else {
            noyakuTableView.isHidden = false
            txtDescriptionLabel.isHidden = true
            btnAddPesticide.isHidden = true
        }
    }
    
    private func setUpSideMenu() {
        let menuViewController = MenuViewController()
        let menuNavigationController = SideMenuNavigationController(rootViewController: menuViewController)
        menuNavigationController.settings = makeSettings()
    
        SideMenuManager.default.leftMenuNavigationController = menuNavigationController
        SideMenuManager.default.rightMenuNavigationController = menuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view, forMenu: .left)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view, forMenu: .right)
    }
    
    @IBAction func tapEdit(_ sender: Any) {
        noyakuTableView.isEditing = !noyakuTableView.isEditing
        editViewChanger(isEditing: noyakuTableView.isEditing)
    }
    
    private func editViewChanger(isEditing: Bool) {
        if (isEditing) {
            let image = UIImage(named: "icon_cancel")!
            btnEdit.image = image
            btnEdit.tintColor = .systemRed
        } else {
            let image = UIImage(named: "icon_edit")!
            btnEdit.image = image
            btnEdit.tintColor = .systemGreen
        }
    }

    private func makeViewEdit() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "icon_edit")!, for: .normal)
        button.tintColor = .systemGreen
        return UIBarButtonItem(customView: button)
    }
    
    //サイドメニューの設定
    private func makeSettings() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.onTopShadowOpacity = 1.0
        settings.statusBarEndAlpha = 0
        return settings
    }

    @objc func catchSelectMenuNotification(notification: Notification) -> Void {
        // メニューからの返り値を取得
        let _ = notification.userInfo
        // Do Something
    }
    
    @IBAction func tapMenuAction(_ sender: Any) {
        let menu = SideMenuManager.default.leftMenuNavigationController!
        present(menu, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! PesticideCustomCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = listData.remove(at: sourceIndexPath.row)
        listData.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.tappedAnimation()
        tableView.deselectRow(at: indexPath, animated: true)
        let dialog = storyboard?.instantiateViewController(withIdentifier: "CustomDialogViewController") as! CustomDialogViewController
        dialog.indexPath = indexPath.row
        
        // 写真変更ダイアログを表示する。
        // 結果を反映させる処理はまだ。
        present(dialog, animated: true)
    }
}
