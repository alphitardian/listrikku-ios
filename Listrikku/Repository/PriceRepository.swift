//
//  PriceRepository.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 02/05/22.
//

import Foundation

class PriceRepository {
    
    let categoryList = ["R-1/TR", "R-2/TR", "R-3/TR", "B-2/TR", "B-3/TR"]
    let powerList = ["900", "1300", "2200", "3300", "4400", "5500", "6600", "200000"]
    let paymentMethodList = ["Pascabayar", "Prabayar"]
    
    func getPrice(category: String, power: String) -> Double {
        /// Rupiah per kwh
        var price = 0.0
        
        switch category {
        case "R-1/TR":
            if power == "900" { price = 1352 }
            else if power == "1300" { price = 1444.70 }
            else if power == "2200" { price = 1444.70 }
        case "R-2/TR":
            if Int(power) ?? 0 >= 3300 || Int(power) ?? 0 <= 5500 { price = 1444.70 }
            else { fatalError("Tidak termasuk dalam kategori listrik tersebut") }
        case "R-3/TR":
            if Int(power) ?? 0 >= 6600 { price = 1444.70 }
            else { fatalError("Tidak termasuk dalam kategori listrik tersebut") }
        case "B-2/TR":
            if Int(power) ?? 0 >= 6600 || Int(power) ?? 0 <= 200000 { price = 1444.70 }
            else { fatalError("Tidak termasuk dalam kategori listrik tersebut") }
        case "B-3/TM":
            if Int(power) ?? 0 >= 200000 { price = 1114.74 }
            else { fatalError("Tidak termasuk dalam kategori listrik tersebut") }
        default:
            price = 1444.70
        }
        
        return price
    }
}
