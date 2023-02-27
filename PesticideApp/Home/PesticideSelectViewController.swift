//
//  PesticideSelectViewController.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2023/02/15.
//

import Foundation
import UIKit
import RealmSwift


class PesticideSelectViewController: UIViewController {
    
    private let cellHeight: CGFloat = 150
    private let pesticideLowerLimit = 3
    
    var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    let realm = try! Realm()
    var pesticideList: Results<Pesticides>!
    
    @IBOutlet weak var noyakuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pesticideList = realm.objects(Pesticides.self)
        noyakuTableView.register(UINib(nibName: "PesticideCustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    @IBAction func touchRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "toRegisterViewFromSelect", sender: nil)
    }
}

extension PesticideSelectViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pesticideList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! PesticideCustomCell
        let limit = pesticideList[indexPath.row].pesticideLimit
        let name = pesticideList[indexPath.row].pesticideName
        let count = pesticideList[indexPath.row].pesticideCount
        let imagePath = pesticideList[indexPath.row].pesticideImagePath
        let fileURL = URL(string: imagePath)
        let filePath = fileURL?.path

        cell.delegate = self
        cell.txtNouyakuCount.text = String(count)
        cell.stepperNouyaku.value = Double(count)
        cell.txtLimitCounter.text = "残回数: \(String(limit - count))"
        cell.nouyakuLimit = limit
        cell.cellIndexPath = indexPath
        cell.txtNouyakuName.text = name
        
        if (limit - count <= pesticideLowerLimit) {
            cell.txtLimitCounter.addAccent(pattern: "\(limit)", color: .red)
        }
        if imagePath != "" {
            cell.imgNouyaku.image = UIImage(contentsOfFile: filePath!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // 編集モードでのみ、スワイプで消せるようにする。
        if tableView.isEditing {
            return UITableViewCell.EditingStyle.delete
        } else {
            return UITableViewCell.EditingStyle.none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // cellの削除処理realmで消してからviewを更新
        try! self.realm.write {
            self.realm.delete(pesticideList[indexPath.row])
        }
//        self.changeIsHiddenTableView()
        noyakuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PesticideSelectViewController: TappedDelegate {
    func cellChangedValue(tapCount: Int, indexPath: IndexPath) {
        try! self.realm.write {
            self.pesticideList[indexPath.row].pesticideCount = tapCount
        }
    }
    
    func tappedNouyakuImage(indexPath: IndexPath) {
        let dialog = storyboard?.instantiateViewController(withIdentifier: "CustomDialogViewController") as! CustomDialogViewController
        print("indexDialog: \(indexPath)")
        dialog.indexPath = indexPath
        dialog.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(dialog, animated: true)
        }
    }
}

extension PesticideSelectViewController: DialogVCDelegate {
    
    func setImageView(image: UIImage, indexPath: IndexPath) {
        print("indexImageView: \(indexPath)")
        let cell = noyakuTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! PesticideCustomCell
        cell.imgNouyaku.image = image
        saveImage(image: image, indexPath: indexPath)
        self.noyakuTableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    private func saveImage(image: UIImage, indexPath: IndexPath) {
        createLocalDataFile()
        let pngImageData = image.pngData()
        do {
            try pngImageData!.write(to: documentDirectoryFileURL)

            try! realm.write {
                pesticideList[indexPath.row].pesticideImagePath = documentDirectoryFileURL.absoluteString
                documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            }
        } catch let error {
            print("DEBUG:: \(error)")
            self.dismiss(animated: true)
            let dialog = UIAlertController(title: "",
                                           message: "画像の保存に失敗しました。もう一度試してください。",
                                           preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    
    func createLocalDataFile() {
        // 作成するテキストファイルの名前
        let fileName = "\(NSUUID().uuidString).png"
        let path = documentDirectoryFileURL.appendingPathComponent(fileName)
        documentDirectoryFileURL = path
    }
}
