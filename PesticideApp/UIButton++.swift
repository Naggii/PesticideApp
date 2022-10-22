//
//  UIButton++.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

import Foundation
import UIKit


extension UIButton {
    override func po
    override func pointInside() -> Bool {
        var rect = bounds
        var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += insets.left + insets.right
        rect.size.height += insets.top + insets.bottom
        return CGRectContainsPoint(rect, point)
    }
}
