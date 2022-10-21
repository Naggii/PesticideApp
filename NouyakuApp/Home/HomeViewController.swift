//
//  ViewController.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/18.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var noyakuTableView: UITableView!
    
    let listData: [String] = ["cell_1","cell_2","cell_3","cell_4","cell_5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noyakuTableView.register(UINib(nibName: "NouyakuCustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        noyakuTableView.delegate = self
        noyakuTableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! NouyakuCustomCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番目の行が選択されました。")
        
        let dialog = storyboard?.instantiateViewController(withIdentifier: "CustomDialogViewController") as! CustomDialogViewController
        
        dialog.indexPath = indexPath.row
        present(dialog, animated: true)
        
    }
    
    
    
}
