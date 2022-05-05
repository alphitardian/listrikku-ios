//
//  ListViewModel.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import Foundation
import CoreData

class ListViewModel {
    
    private var userItemRepository = UserItemRepository()
    private var userProfileRepository = UserProfileRepository()
    private var priceRepository = PriceRepository()
    private var userItems = [Electronic]()
    
    func saveItem(data: Electronic) {
        userItemRepository.save(data: data)
    }
    
    func loadItems() -> [Electronic] {
        userItems = userItemRepository.load()
        return userItems
    }
    
    func calculateBillEstimation() -> String {
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
    
    func getUserProfile() -> User? {
        return userProfileRepository.load().first
    }
    
    func convertToKWH(value: Int) -> Double {
        return Double(value) / 1000
    }
}
