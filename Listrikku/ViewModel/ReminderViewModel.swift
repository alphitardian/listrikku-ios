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
        var data: Bill?
        if !userBillRepository.load().isEmpty {
            data = userBillRepository.load().last
        }
        return data
    }
    
    func getUserLastBill() -> Bill? {
        var index = 0
        if !userBillRepository.load().isEmpty {
            index = userBillRepository.load().count - 2
            
            if index == -1 {
                return userBillRepository.load().last
            } else {
                return userBillRepository.load()[index]
            }
        } else {
            return nil
        }
    }
    
    func scheduleReminder(date: Date) {
        NotificationHelper.scheduleReminder(date: date)
    }
}
