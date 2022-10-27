//
//  RegisterCheckViewController.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

import Foundation
import UIKit
import RealmSwift


class RegisterCheckViewController: UIViewController {
    
    let realm = try! Realm()

    var pesticideName = ""
    var pesticideLimit = 0
    
    @IBOutlet weak var lblPesticideLimit: UILabel!
    @IBOutlet weak var lblPesticideName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPesticideName.text = pesticideName
        lblPesticideLimit.text = String(pesticideLimit)
    }
    
    @IBAction func touchUpRegister(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            homeVc.modalTransitionStyle = .crossDissolve
            homeVc.modalPresentationStyle = .fullScreen
            homeVc.pesticideDataList.append(PesticideData.init(name: self.pesticideName, limit: self.pesticideLimit))
            
            let pesticides = Pesticides()
            pesticides.pesticideName = self.pesticideName
            pesticides.pesticideLimit = self.pesticideLimit
            try! self.realm.write {
                self.realm.add(pesticides)
            }
            self.present(homeVc, animated: true, completion: nil)
        }
    }
    
}
