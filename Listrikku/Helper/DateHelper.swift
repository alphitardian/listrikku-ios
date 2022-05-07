//
//  DateHelper.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 06/05/22.
//

import Foundation

extension Date {
    func getFullDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ID")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
}
