//
//  DatabaseHelperDelegate.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import Foundation

// Apply protocol oriented programming
protocol DatabaseHelperDelegate {
    associatedtype Item // Generic Type
    
    func save(data: Item)
    func load() -> [Item]
    func update(id: UUID, data: Item)
    func delete(id: UUID)
}

extension DatabaseHelperDelegate {
    // Default value for optional function
    func update(id: UUID, data: Item) {}
    func delete(id: UUID) {}
}
