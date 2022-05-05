//
//  ViewComponent.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 02/05/22.
//

import UIKit

let UI_SCREEN_WIDTH = UIScreen.main.bounds.width - 10
let UI_SCREEN_HEIGHT = UIScreen.main.bounds.height / 2

func setPrimaryButtonShadow(for button: UIButton?) {
    if let button = button {
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 7
        button.layer.shadowOpacity = 0.7
    }
}
