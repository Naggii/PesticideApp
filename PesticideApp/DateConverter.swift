//
//  DateConverter.swift
//  PesticideApp
//
//  Created by nagai on 2023/02/21.
//

import Foundation

extension Date {

    func toStringWithCurrentLocale() -> String {

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return formatter.string(from: self)
    }

}
