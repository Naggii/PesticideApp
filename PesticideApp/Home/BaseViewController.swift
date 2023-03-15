//
//  BaseViewController.swift
//  PesticideApp
//
//  Created by nagai on 2023/03/03.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    @objc func stepperValueChanged(_ sender: UIStepper) -> Int {
        // UIStepperの値をUITextViewに表示
        return Int(sender.value)
    }
    
    
    func tutorialDialog() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let dialog = UIAlertController(title: "インストールありがとうございます！",
                                           message: "このアプリは、簡単に農薬を登録して散布回数を管理することができるアプリです。\n今後のアップデートで更に機能を追加していきます。",
                                           preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    func registerDialog() {
        let dialog = UIAlertController(title: "まずは、登録しましょう！😆",
                                       message: "下のボタンの登録するボタンから登録できます。\n農薬を準備してください！",
                                       preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    
    func showQuestionPesUseCount(
//        pesName: String,
//        pesCount: Int,
//        pesLimit: Int,
//        completion:(Bool) -> Void
    ){


        // アラートを表示
//        present(alertController, animated: true, completion: nil)
        
    }
    

    
}
