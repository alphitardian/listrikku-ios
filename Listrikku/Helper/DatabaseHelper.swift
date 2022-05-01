//
//  DatabaseHelper.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import UIKit
import CoreData

class DatabaseHelper {
    
    static let sharedInstance = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveUserItem(data: Electronic) {
        let instance = UserItem(context: context)
        instance.name = data.name
        instance.power = data.power
        instance.duration = data.duration
        instance.image = data.image
        
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadUserItems() -> [Electronic] {
        var userItems = [Electronic]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserItem")
        
        do {
            let data = try context.fetch(fetchRequest) as! [UserItem]
            userItems = data.map({ item in
                Electronic(name: item.name, power: item.power, duration: item.duration, image: item.image)
            })
            print("Data fetched!")
        } catch {
            print(error.localizedDescription)
        }
        
        return userItems
    }
}
