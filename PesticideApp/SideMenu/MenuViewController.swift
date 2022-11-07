//
//  MenuViewController.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/22.
//

import UIKit
import SideMenu


// SIDE_MENU
// 機能はまだ作ってないのでいずれ作りたいね。٩( ᐛ )و
 
class MenuViewController: UITableViewController {
    var items: [String] = ["農薬登録画面"]
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // 背景色は白にする
        view.backgroundColor = .white
         
        // 見た目調整
        self.navigationController?.navigationBar.tintColor = .clear
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.isTranslucent = true
         
        // TableView を追加
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        
        tableView.deselectRow(at: indexPath, animated: true)
        // サイドバーを閉じる
        dismiss(animated: true, completion: nil)

        NotificationCenter.default.post(
            name: Notification.Name("SelectMenuNotification"),
            object: nil,
            userInfo: ["itemNo": indexPath.row] 
        )
    }
}
