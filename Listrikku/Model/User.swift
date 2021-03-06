//
//  User.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 28/04/22.
//

import Foundation

struct User: Identifiable {
    var id: UUID
    var name: String?
    var category: String?
    var paymentMethod: String?
    var power: String?
}
