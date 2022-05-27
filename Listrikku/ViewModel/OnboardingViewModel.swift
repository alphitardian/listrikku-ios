//
//  OnboardingViewModel.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import Foundation

class OnboardingViewModel {
    
    static let sharedInstance = OnboardingViewModel()
    
    private var userProfileRepository = UserProfileRepository()
    private var priceRepository = PriceRepository()
    
    lazy var category = priceRepository.categoryList
    lazy var payment = priceRepository.paymentMethodList
    lazy var power = priceRepository.powerList
    
    // set value privately, but get value publicly
    private(set) var userName: String?
    private(set) var selectedCategory: Int?
    private(set) var selectedPower: Int?
    private(set) var selectedPaymentMethod: Int?
    
    func saveUser() {
        let user = User(
            id: UUID(),
            name: userName ?? "",
            category: category[selectedCategory ?? 0],
            paymentMethod: payment[selectedPaymentMethod ?? 0],
            power: power[selectedPower ?? 0]
        )
        userProfileRepository.save(data: user)
    }
    
    func loadUser() -> User? {
        return userProfileRepository.load().first
    }
    
    func loadComponentDetail(tag: Int) -> String {
        return userProfileRepository.componentInfo[tag]
    }
    
    func setUserName(name: String) {
        userName = name
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
}
