//
//  FSCalender++.swift
//  PesticideApp
//
//  Created by nagai on 2023/03/06.
//

import Foundation
import FSCalendar


extension FSCalendar {
    
    func setUpGilSansFonts() {
        appearance.titleFont = UIFont(name: "GillSans-Bold", size: 24)
        appearance.weekdayFont = UIFont(name: "GillSans-SemiBold", size: 18)
        appearance.headerTitleFont = UIFont(name: "GillSans-Bold", size: 20)
    }
    
    
    func changeWeekDayLabelToJP() {
        // FSCalenderの曜日を日本語に変換する。
        let calenderLabels = calendarWeekdayView.weekdayLabels
        calenderLabels.enumerated().forEach({ index, _ in
            calenderLabels[index].text = convertIndexToWeekDay(index: index)
        })
    }
    
    private func convertIndexToWeekDay(index: Int) -> String {
        switch index {
        case 0: return "日"
        case 1: return "月"
        case 2: return "火"
        case 3: return "水"
        case 4: return "木"
        case 5: return "金"
        case 6: return "土"
        default:
            return ""
        }
    }
}
