//
//  UITableViewCell+.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

import Foundation
import UIKit


// tap animation ++
// tapで少し小さくtransformし、その後すぐにtransformし直す

extension UITableViewCell {
    func tappedAnimation()  {
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: 0.96, y: 0.96)
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: [], animations: {
                self.transform = transform
            }, completion: {_ in
                var transform = CGAffineTransform.identity
                transform = transform.scaledBy(x: 1.0, y: 1.0)
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0,
                    options: [], animations: {
                        self.transform = transform
                    }, completion: nil)
            }
        )
    }
}

extension UIImageView {
    func tappedAnimation()  {
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: 0.96, y: 0.96)
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: [], animations: {
                self.transform = transform
            }, completion: {_ in
                var transform = CGAffineTransform.identity
                transform = transform.scaledBy(x: 1.0, y: 1.0)
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0,
                    options: [], animations: {
                        self.transform = transform
                    }, completion: nil)
            }
        )
    }
}

