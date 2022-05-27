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
    
    let componentInfo = [
        "Kategori listrik merupakan kategori yang digunakan untuk menentukan golongan tarif.",
        "Jenis pembayaran berdasarkan tagihan (pascabayar) atau token (prabayar).",
        "Daya listrik merupakan tegangan listrik yang telah terpasang."
    ]
    
    func save(data: User) {
        let instance = UserProfile(context: databaseContext)
        instance.id = data.id
        instance.name = data.name
        instance.power = data.power
        instance.category = data.category
        instance.payment = data.paymentMethod
        
        do {
            try databaseContext.save()
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
                User(id: item.id!, name: item.name, category: item.category, paymentMethod: item.payment, power: item.power)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return userProfiles
    }
    
    func update(id: UUID, data: User) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        do {
            let result = try databaseContext.fetch(fetchRequest) as! [UserProfile]
            let item = result.first
            item?.name = data.name
            item?.power = data.power
            item?.category = data.category
            item?.payment = data.paymentMethod
            
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        do {
            let result = try databaseContext.fetch(fetchRequest) as! [UserProfile]
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
