//
//  ViewController.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/18.
//

import UIKit
import SwiftGifOrigin
import SideMenu
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    @IBOutlet weak var btnAddPesticide: BGButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        changeIsHiddenTableView()
        setUpSideMenu()
        // サイドバーメニューからの通知を受け取る
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(catchSelectMenuNotification(notification:)),
            name: Notification.Name("SelectMenuNotification"),
            object: nil
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isNotFirst = UserDefaults.standard.bool(forKey: "isFirstOpend")
        if !isNotFirst {
            tutorialDialog()
            UserDefaults.standard.set(true, forKey: "isFirstOpend")
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
    
    private func tutorialDialog() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let dialog = UIAlertController(title: "インストールありがとうございます！",
                                           message: "このアプリは、簡単に農薬を登録して散布回数を管理することができるアプリです。\n今後のアップデートで更に機能を追加していきます。",
                                           preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
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
    
    private func makeSettings() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.onTopShadowOpacity = 1.0
        settings.statusBarEndAlpha = 0
        return settings
    }
    
    @objc func catchSelectMenuNotification(notification: Notification) -> Void {
        // メニューからの返り値を取得
        let registerMenuRow = 0
        let row = notification.userInfo!["itemNo"] as! Int
        if row == registerMenuRow {
            transitionRegisterView()
        }
    }
    
    @IBAction func tapMenuAction(_ sender: Any) {
        let menu = SideMenuManager.default.leftMenuNavigationController!
        present(menu, animated: true, completion: nil)
    }
    
    private func transitionRegisterView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnAddPesticide.alpha = 0
            }, completion:  { _ in
                // self.noyakuTableView.isHidden = false
                self.btnAddPesticide.isHidden = true
                
                self.performSegue(withIdentifier: "toRegisterView", sender: nil)
            })
        }
    }
}

//    @IBAction func tapEdit(_ sender: Any) {
//        guard !noyakuTableView.isHidden else {
//            let dialog = UIAlertController(title: "まずは、登録しましょう！😆",
//                                           message: "下のボタンの登録するボタンから登録できます。\n農薬を準備してください！",
//                                           preferredStyle: .alert)
//            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(dialog, animated: true, completion: nil)
//            return
//        }
//        noyakuTableView.isEditing = !noyakuTableView.isEditing
//        editViewChanger(isEditing: noyakuTableView.isEditing)
//    }


// nope
//    private func changeIsHiddenTableView() {
//        if pesticideList == nil || pesticideList.isEmpty {
//            noyakuTableView.isHidden = true
//            txtDescriptionLabel.isHidden = false
//            btnAddPesticide.isHidden = false
//        } else {
//            noyakuTableView.isHidden = false
//            txtDescriptionLabel.isHidden = true
//            btnAddPesticide.isHidden = true
//        }
//    }
