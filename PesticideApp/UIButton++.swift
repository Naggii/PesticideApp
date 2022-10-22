//
//  UIButton++.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

import Foundation
import UIKit


extension UIButton {
    func animateView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
        }) { (_) in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                self.transform = .identity
                
            }, completion: nil)
        }
    }
}
