//
//  Dialog++.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

import UIKit

extension UIAlertController {
    static func addAlertWithValidation(
        register: @escaping (_ text: String) -> Void
    ) -> UIAlertController {
        let descriptionString = "入力してください"
        let validationString = "5文字以内で入力してください"
    var alert = UIAlertController()
        var token: NSObjectProtocol?
        
        // UIAlertControllerを作成する
        alert = UIAlertController(title: "登録ダイアログ", message: descriptionString, preferredStyle: .alert)
        
        // 登録時の処理
        let registerAction = UIAlertAction(title: "登録", style: .default, handler: { _ in
            guard let textFields = alert.textFields else { return }
            guard let text = textFields[0].text else { return }
            register(text)
            guard let token = token else { return }
            // オブサーバ登録を解除・・・①
            NotificationCenter.default.removeObserver(token)
        })
        
        // キャンセル時の処理
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { _ in
            guard let token = token else { return }
            // オブサーバ登録を解除・・・①
            NotificationCenter.default.removeObserver(token)
        })
        
        // テキストフィールドを追加
        alert.addTextField { (textField: UITextField!) -> Void in
            // テキスト変更の通知を受け取るためにオブサーバを登録する・・・②
            token = NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: nil) { _ in
                let text = textField.text ?? ""
                registerAction.isEnabled = false
                if text.count > 5 {
                    // 入力文字が5文字より多い場合(バリデーションエラー)
                    let messageString = "\(descriptionString)\n\(validationString)"
                    let range: NSRange = NSString(string: messageString).range(of: validationString )
                    let alertText = NSMutableAttributedString(string: messageString)
            // validationStringのみを赤字にする・・・③
                    alertText.addAttributes([
                        .foregroundColor: UIColor.red,
                    ], range: range)
                    alert.setValue(alertText, forKey: "attributedMessage")
                } else {
                    // 入力文字が5文字以内の場合(正常)
                    let alertText = NSMutableAttributedString(string: descriptionString)
                    alert.setValue(alertText, forKey: "attributedMessage")
                    if text.count != 0 {
            // 登録ボタン非活性(未入力時)
                        registerAction.isEnabled = true
                    }
                }
            }
        }
        // 登録ボタン非活性(初期表示)
        registerAction.isEnabled = false
        
        alert.addAction(cancelAction)
        alert.addAction(registerAction)

        return alert
    }
}

