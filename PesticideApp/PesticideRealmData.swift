//
//  PesticideRealmData.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/28.
//

import Foundation
import RealmSwift


class Pesticides: Object {
    @objc dynamic var pesticideName : String = ""
    @objc dynamic var pesticideLimit: Int = 0
    @objc dynamic var pesticideCount: Int = 0
    @objc dynamic var pesticideImagePath: String = ""
}
