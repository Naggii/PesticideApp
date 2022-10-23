//
//  PesticideRegisterViewController.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

import Foundation
import UIKit


class PesticideRegisterViewController: UIViewController {
    @IBOutlet weak var fieldPesticide: UITextField!
    @IBOutlet weak var fieldPesticideLimit: UITextField!
    @IBAction func touchUpButton(_ sender: Any) {
        if (fieldPesticide.text != nil || fieldPesticideLimit.text != nil) {
            self.performSegue(withIdentifier: "toCheckView", sender: nil)
        } else {
            let dialog = UIAlertController(title: "oops",
                                           message:"return",
                                           preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        fieldPesticide.text = textField.text
        return true
    }
    
}
