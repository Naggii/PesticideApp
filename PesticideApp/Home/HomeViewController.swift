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
import FSCalendar

class HomeViewController: BaseViewController {
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var pesCalendar: FSCalendar!
    @IBOutlet weak var btnAddPesticide: BGButton!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var homeNavBar: UINavigationBar!
    @IBOutlet weak var dayInfoTableView: UITableView!
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setUpView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isNotFirst = UserDefaults.standard.bool(forKey: "isFirstOpend")
        if !isNotFirst {
            tutorialDialog()
            UserDefaults.standard.set(true, forKey: "isFirstOpend")
        }
    }
    
    private func setUpView() {
        let menuViewController = MenuViewController()
        let menuNavigationController = SideMenuNavigationController(rootViewController: menuViewController)
        menuNavigationController.settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController = menuNavigationController
        SideMenuManager.default.rightMenuNavigationController = menuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view, forMenu: .left)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view, forMenu: .right)
        
        pesCalendar.setUpGilSansFonts()
        pesCalendar.changeWeekDayLabelToJP()
        
        // サイドバーメニューからの通知を受け取る
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(catchSelectMenuNotification(notification:)),
            name: Notification.Name("SelectMenuNotification"),
            object: nil
        )
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
        self.performSegue(withIdentifier: "toRegisterView", sender: nil)
    }
}

extension HomeViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date
        dayInfoTableView.reloadData()
//        self.performSegue(withIdentifier: "toPesSelectView", sender: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let initialData = "\(self.date.toStringWithCurrentLocale())"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = initialData
        return cell
    }
}
