//
//  SplashViewController.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/22.
//

import Foundation
import UIKit


class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("つん")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(nextViewController, animated: true, completion: nil)
    }
}
