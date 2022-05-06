//
//  NumberFormatter.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 05/05/22.
//

import UIKit

class NumberFormatterHelper {
    static func convertToRupiah(value: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter.string(from: value as NSNumber)
    }
}
