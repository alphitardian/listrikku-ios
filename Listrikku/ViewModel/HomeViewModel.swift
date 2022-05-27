//
//  HomeViewModel.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 05/05/22.
//

import Foundation
import CoreData

class HomeViewModel {
    
    private var userBillRepository = UserBillRepository()
    private var userProfileRepository = UserProfileRepository()
    private var priceRepository = PriceRepository()
    
    lazy var category = priceRepository.categoryList
    lazy var payment = priceRepository.paymentMethodList
    lazy var power = priceRepository.powerList
    
    private(set) var loadedUser: User?
    private(set) var selectedCategory: Int?
    private(set) var selectedPower: Int?
    private(set) var selectedPaymentMethod: Int?
    
    init() {
        loadUserProfile()
    }
    
    func loadUserBills() -> [Bill] {
        return userBillRepository.load()
    }
    
    func loadUserProfile() {
        loadedUser = userProfileRepository.load().first
    }
    
    func updateUserProfile() {
        if let user = loadedUser {
            let updatedData = User(
                id: user.id,
                name: user.name,
                category: category[selectedCategory ?? 0],
                paymentMethod: payment[selectedPaymentMethod ?? 0],
                power: power[selectedPower ?? 0]
            )
            userProfileRepository.update(id: user.id, data: updatedData)
        }
    }
    
    func deleteUserProfile() {
        if let user = loadedUser {
            userProfileRepository.delete(id: user.id)
        }
    }
    
    func loadComponentDetail(tag: Int) -> String {
        return userProfileRepository.componentInfo[tag]
    }
    
    func setCategory(at index: Int) {
        selectedCategory = index
    }
    
    func setSelectedPower(at index: Int) {
        selectedPower = index
    }
    
    func setSelectedPaymentMethod(at index: Int) {
        selectedPaymentMethod = index
    }
    
    func registerReminder() {
        NotificationHelper.registerReminder()
    }
}
