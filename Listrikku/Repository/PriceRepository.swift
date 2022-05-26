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
        // Rupiah per kwh
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
    
    func getPrepaidCost(value: Double) -> Double {
        var price = 0.0
        
        switch value {
        case 0..<20000:
            price = 20000
        case 20000..<50000:
            price = 50000
        case 50000..<100000:
            price = 100000
        case 100000..<200000:
            price = 200000
        case 200000..<500000:
            price = 500000
        case 500000..<1000000:
            price = 1000000
        case 1000000..<5000000:
            price = 5000000
        case 5000000..<10000000:
            price = 10000000
        case 10000000..<50000000:
            price = 50000000
        default:
            price = 0
        }
        
        return price
    }
}
