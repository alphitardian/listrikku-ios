//
//  ListViewModel.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import Foundation
import CoreData

class ListViewModel {
    
    private var userItemRepository = UserItemRepository()
    private var userItems = [Electronic]()
    
    func saveItem(data: Electronic) {
        userItemRepository.save(data: data)
    }
    
    func loadItems() -> [Electronic] {
        return userItemRepository.load()
    }
    
    func calculateBillEstimation() {
        var result = 0
        for value in userItems {
            let power = Int(value.power ?? "0") ?? 0
            let duration = Int(value.duration ?? "0") ?? 0
            let total = power * duration
            result += total
        }
        print("result: \(result)")
    }
}
