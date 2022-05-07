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
    
    func loadUserBills() -> [Bill] {
        return userBillRepository.load()
    }
    
    func registerReminder() {
        NotificationHelper.registerReminder()
    }
}
