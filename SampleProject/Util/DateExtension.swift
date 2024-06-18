//
//  DateExtension.swift
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
