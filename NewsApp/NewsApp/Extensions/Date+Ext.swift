//
//  Date+Ext.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale     = Locale(identifier: "ru")
        dateFormatter.timeZone   = .current
        return dateFormatter.string(from: self).capitalized
    }
}
