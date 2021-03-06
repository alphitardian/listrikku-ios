//
//  Electronic.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 30/04/22.
//

import Foundation

struct Electronic: Identifiable {
    var id: UUID
    var name: String?
    var quantity: Int?
    var power: String?
    var duration: String?
    var image: Data?
}
