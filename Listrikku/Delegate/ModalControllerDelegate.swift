//
//  ModalControllerDelegate.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import Foundation

protocol ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T)
    func moveToRoot<T>(_ modal: T)
}

extension ModalControllerDelegate {
    func moveToRoot<T>(_ modal: T) {}
}
