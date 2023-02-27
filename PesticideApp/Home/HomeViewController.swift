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

class HomeViewController: UIViewController {
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var pesCalendar: FSCalendar!
    @IBOutlet weak var btnAddPesticide: BGButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        pesCalendar.appearance.titleFont = UIFont(name: "GillSans-Bold", size: 24)
//        pesCalendar.appearance.subtitleFont = UIFont(name: "Noteworthy Bold", size: 20)
        pesCalendar.appearance.weekdayFont = UIFont(name: "GillSans-SemiBold", size: 18)
        pesCalendar.appearance.headerTitleFont = UIFont(name: "GillSans-Bold", size: 20)
        // FSCalenderの曜日を日本語に変換する。
        let calenderLabels = pesCalendar.calendarWeekdayView.weekdayLabels
        calenderLabels.enumerated().forEach({ index, _ in
            calenderLabels[index].text = DateConverter().convertIndexToWeekDay(index: index)
        })
        
        // サイドバーメニューからの通知を受け取る
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(catchSelectMenuNotification(notification:)),
            name: Notification.Name("SelectMenuNotification"),
            object: nil
        )
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
        self.performSegue(withIdentifier: "toPesSelectView", sender: nil)
    }
}
