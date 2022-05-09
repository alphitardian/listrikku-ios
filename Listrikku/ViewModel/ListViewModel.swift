//
//  ListViewModel.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import Foundation
import CoreData

class ListViewModel {
    
    static let sharedInstance = ListViewModel()
    
    private var userItemRepository = UserItemRepository()
    private var userProfileRepository = UserProfileRepository()
    private var userBillRepository = UserBillRepository()
    private var priceRepository = PriceRepository()
    private var userItems = [Electronic]()
    
    func saveItem(data: Electronic) {
        userItemRepository.save(data: data)
    }
    
    func loadItems() -> [Electronic] {
        userItems = userItemRepository.load()
        return userItems
    }
    
    func updateItem(id: UUID, data: Electronic) {
        userItemRepository.update(id: id, data: data)
    }
    
    func deleteItem(id: UUID) {
        userItemRepository.delete(id: id)
    }
    
    func saveUserBill(data: Bill) {
        userBillRepository.save(data: data)
    }
    
    func loadUserBills() -> [Bill] {
        return userBillRepository.load()
    }
    
    func getUserNextBill() -> Bill? {
        var data: Bill?
        if !userBillRepository.load().isEmpty {
            data = userBillRepository.load().last
        }
        return data
    }
    
    func calculatePostpaidBillEstimation() -> String {
        var result = 0
        let userCategory = getUserProfile()?.category
        let userPower = getUserProfile()?.power
        let basePrice = priceRepository.getPrice(category: userCategory ?? "", power: userPower ?? "")
        
        for value in userItems {
            let quantity = value.quantity ?? 1
            let power = Int(value.power ?? "0") ?? 0
            let duration = Int(value.duration ?? "0") ?? 0
            let total = quantity * power * duration
            result += total
        }
        
        /// Monthly Estimation
        let estimation = (convertToKWH(value: result) * basePrice) * 30
        return String(estimation)
    }
    
    func calculatePrepaidBillEstimation() -> (cost: String, kwh: Double) {
        var result = 0
        let userCategory = getUserProfile()?.category
        let userPower = getUserProfile()?.power
        let basePrice = priceRepository.getPrice(category: userCategory ?? "", power: userPower ?? "")
        
        for value in userItems {
            let quantity = value.quantity ?? 1
            let power = Int(value.power ?? "0") ?? 0
            let duration = Int(value.duration ?? "0") ?? 0
            let total = quantity * power * duration
            result += total
        }
        
        /// Monthly Estimation
        let estimation = (convertToKWH(value: result) * basePrice) * 30
        let cost = priceRepository.getPrepaidCost(value: estimation)
        return (cost: "\(cost)", kwh: convertToKWH(value: result))
    }
    
    func calculatePrepaidDuration(cost: String, kwh: Double) -> Int {
        let userCategory = getUserProfile()?.category
        let userPower = getUserProfile()?.power
        let basePrice = priceRepository.getPrice(category: userCategory ?? "", power: userPower ?? "")
        var powerPerDay = kwh
        let powerFromToken = (Double(cost) ?? 0.0) / basePrice
        
        if powerPerDay == 0 { powerPerDay = 1 } // Protection to avoid infinite result
        return Int(round(powerFromToken / powerPerDay))
    }
    
    func getUserProfile() -> User? {
        return userProfileRepository.load().first
    }
    
    func convertToKWH(value: Int) -> Double {
        return Double(value) / 1000
    }
    
    func scheduleReminder(date: Date, message: String) {
        NotificationHelper.scheduleReminder(date: date, customMessage: message)
    }
}
