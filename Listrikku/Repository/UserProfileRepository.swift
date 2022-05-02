//
//  UserProfileRepository.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 02/05/22.
//

import Foundation
import CoreData

class UserProfileRepository: DatabaseHelperDelegate {
    typealias Item = User
    
    private let databaseContext = DatabaseHelper.sharedInstance.context
    
    func save(data: User) {
        let instance = UserProfile(context: databaseContext)
        instance.name = data.name
        instance.power = data.power
        instance.category = data.category
        instance.payment = data.paymentMethod
        
        do {
            try databaseContext.save()
            print("Data saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> [User] {
        var userProfiles = [User]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        
        do {
            let data = try databaseContext.fetch(fetchRequest) as! [UserProfile]
            userProfiles = data.map { item in
                User(name: item.name, category: item.category, paymentMethod: item.payment, power: item.power)
            }
            print("Data fetched!")
        } catch {
            print(error.localizedDescription)
        }
        
        return userProfiles
    }
}