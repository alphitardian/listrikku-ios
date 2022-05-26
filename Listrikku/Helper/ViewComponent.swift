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
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3
    }
}

func appPrimaryColor() -> UIColor {
    return UIColor(red: 0/255, green: 194/255, blue: 203/255, alpha: 1)
}

func setupPickerView(tag: Int, sender: UIViewController) -> (controller: UIViewController, view: UIPickerView) {
    let viewController = UIViewController()
    viewController.preferredContentSize = CGSize(width: UI_SCREEN_WIDTH, height: UI_SCREEN_HEIGHT)
    
    let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: UI_SCREEN_WIDTH, height: UI_SCREEN_HEIGHT))
    pickerView.delegate = sender as? UIPickerViewDelegate
    pickerView.dataSource = sender as? UIPickerViewDataSource
    pickerView.tag = tag
    
    viewController.view.addSubview(pickerView)
    
    pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
    pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
    
    return (controller: viewController, view: pickerView)
}

func setupAlertPicker(messageDetail: String, viewController: UIViewController, pickerView: UIPickerView, sender: UIViewController, selectionHandler: @escaping (UIAlertAction) -> Void) {
    let alert = UIAlertController(title: "Pilih Salah Satu", message: messageDetail, preferredStyle: .actionSheet)
    
    let titleAttribute = [NSAttributedString.Key.font: UIFont.preferredFont(for: .body, weight: .medium)]
    let titleString = NSAttributedString(string: "Pilih Salah Satu", attributes: titleAttribute)
    alert.setValue(titleString, forKey: "attributedTitle")
    alert.setValue(viewController, forKey: "contentViewController")
    alert.addAction(UIAlertAction(title: "Kembali", style: .cancel, handler: { UIAlertAction in }))
    alert.addAction(UIAlertAction(title: "Pilih", style: .default, handler: selectionHandler))
    sender.present(alert, animated: true, completion: nil)
}
