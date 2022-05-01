//
//  DatabaseHelperDelegate.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import Foundation

// Apply protocol oriented programming
protocol DatabaseHelperDelegate {
    associatedtype Item
    
    func save(data: Item)
    func load() -> [Item]
}
