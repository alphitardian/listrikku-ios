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
        instance.id = data.id
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
                Electronic(id: item.id!, name: item.name, quantity: Int(item.quantity), power: item.power, duration: item.duration, image: item.image)
            }
            print("Data fetched!")
        } catch {
            print(error.localizedDescription)
        }
        
        return userItems
    }
    
    func update(id: UUID, data: Electronic) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserItem")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        do {
            let result = try databaseContext.fetch(fetchRequest) as! [UserItem]
            let item = result.first
            item?.name = data.name
            item?.quantity = Int32(data.quantity ?? 0 )
            item?.power = data.power
            item?.duration = data.duration
            item?.image = data.image
            
            do {
                try databaseContext.save()
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserItem")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        do {
            let result = try databaseContext.fetch(fetchRequest) as! [UserItem]
            let item = result.first
            
            if let item = item {
                databaseContext.delete(item)
            }
            
            do {
                try databaseContext.save()
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
