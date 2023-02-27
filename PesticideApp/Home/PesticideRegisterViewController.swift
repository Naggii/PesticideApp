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
    
    private var textName = ""
    private var limit = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCheckView" {
            let next = segue.destination as? RegisterCheckViewController
            next?.pesticideName = fieldPesticide.text!
            next?.pesticideLimit = Int(fieldPesticideLimit.text!)!
        }
    }

    @IBAction func tapToback(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpButton(_ sender: Any) {
        if (fieldPesticide.text != nil || fieldPesticideLimit.text != nil) {
            textName = fieldPesticide.text!
            limit = Int(fieldPesticideLimit.text!)!
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
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        let done = UIBarButtonItem(title: "完了",
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapDoneButton))
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        
        fieldPesticide.inputAccessoryView = toolbar
        fieldPesticideLimit.inputAccessoryView = toolbar
        
        
        fieldPesticideLimit.keyboardType = .numberPad
    }
    
    //完了ボタンを押した時の処理
    @objc func didTapDoneButton() {
        fieldPesticide.resignFirstResponder()
        fieldPesticideLimit.resignFirstResponder()
    }
    
}
extension PesticideRegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == fieldPesticideLimit {
            let maxLength: Int = 2
            let str = textField.text! + string
            if str.count <= maxLength {
                return true
            }
        } else {
            let maxLength: Int = 20
            let str = textField.text! + string
            if str.count <= maxLength {
                return true
            }
        }
        return false
    }
}
