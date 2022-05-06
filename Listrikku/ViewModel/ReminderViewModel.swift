//
//  ReminderViewModel.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 06/05/22.
//

import Foundation
import CoreData

class ReminderViewModel {
    
    private var userBillRepository = UserBillRepository()
    
    func getUserNextBill() -> Bill? {
        return userBillRepository.load().last
    }
    
    func getUserLastBill() -> Bill? {
        let index = userBillRepository.load().count - 2
        return userBillRepository.load()[index]
    }
}
