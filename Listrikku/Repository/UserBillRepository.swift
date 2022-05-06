//
//  UserBillRepository.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 05/05/22.
//

import Foundation
import CoreData

class UserBillRepository: DatabaseHelperDelegate {
    typealias Item = Bill
    
    private let databaseContext = DatabaseHelper.sharedInstance.context
    
    func save(data: Bill) {
        let instance = BillEntity(context: databaseContext)
        instance.billEstimation = data.billEstimation ?? 0.0
        instance.date = data.date
        instance.id = data.id
        
        do {
            try databaseContext.save()
            print("Bill saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> [Bill] {
        var userBills = [Bill]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BillEntity")
        
        do {
            let data = try databaseContext.fetch(fetchRequest) as! [BillEntity]
            userBills = data.map { item in
                Bill(id: item.id, billEstimation: item.billEstimation, date: item.date)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return userBills
    }
}
