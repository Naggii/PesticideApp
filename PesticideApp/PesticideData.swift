//
//  Pesticide.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

import Foundation

// TODO:　今後のupdateで情報を増やす
struct PesticideData {
    var pesticideName = ""
    var pesticideLimit = 0
    
    init(name: String, limit: Int) {
        self.pesticideName = name
        self.pesticideLimit = limit
    }
}
