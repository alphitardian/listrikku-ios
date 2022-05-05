//
//  UserItemRepository.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 02/05/22.
//

import Foundation
import CoreData

class UserItemRepository: DatabaseHelperDelegate {
    typealias Item = Electronic
    
    private let databaseContext = DatabaseHelper.sharedInstance.context
    
    func save(data: Electronic) {
        let instance = UserItem(context: databaseContext)
        instance.name = data.name
        instance.quantity = Int32(data.quantity ?? 0)
        instance.power = data.power
        instance.duration = data.duration
        instance.image = data.image
        
        do {
            try databaseContext.save()
            print("Data saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> [Electronic] {
        var userItems = [Electronic]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserItem")
        
        do {
            let data = try databaseContext.fetch(fetchRequest) as! [UserItem]
            userItems = data.map { item in
                Electronic(name: item.name, quantity: Int(item.quantity), power: item.power, duration: item.duration, image: item.image)
            }
            print("Data fetched!")
        } catch {
            print(error.localizedDescription)
        }
        
        return userItems
    }
}
