//
//  ProfileInputViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 28/04/22.
//

import UIKit

class ProfileInputViewController: UIViewController {

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var powerButton: UIButton!
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedCategory = 0
    var selectedPayment = 0
    var selectedPower = 0
    
    let categories = ["RI-1", "RI-2"]
    let payments = ["Prabayar", "Pascabayar"]
    let powers = [450, 900, 1300, 2200]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func onCategoryClick(_ sender: UIButton) {
        let categoryPickerView = setupPickerView(tag: 0)
        setupAlertPicker(viewController: categoryPickerView.0, pickerView: categoryPickerView.1) { UIAlertAction in
            self.selectedCategory = categoryPickerView.1.selectedRow(inComponent: 0)
            let selected = self.categories[self.selectedCategory]
            self.categoryButton.setTitle(selected, for: .normal)
        }
    }
    
    @IBAction func onPaymentClick(_ sender: UIButton) {
        let paymentPickerView = setupPickerView(tag: 1)
        setupAlertPicker(viewController: paymentPickerView.0, pickerView: paymentPickerView.1) { UIAlertAction in
            self.selectedPayment = paymentPickerView.1.selectedRow(inComponent: 0)
            let selected = self.payments[self.selectedPayment]
            self.paymentButton.setTitle(selected, for: .normal)
        }
    }
    
    @IBAction func onPowerClick(_ sender: UIButton) {
        let powerPickerView = setupPickerView(tag: 2)
        setupAlertPicker(viewController: powerPickerView.0, pickerView: powerPickerView.1) { UIAlertAction in
            self.selectedPower = powerPickerView.1.selectedRow(inComponent: 0)
            let selected = self.powers[self.selectedPower]
            self.powerButton.setTitle("\(selected)", for: .normal)
        }
    }
    
    private func setupPickerView(tag: Int) -> (UIViewController, UIPickerView) {
        let viewController = UIViewController()
        viewController.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = tag
        pickerView.selectRow(selectedCategory, inComponent: 0, animated: false)
        
        viewController.view.addSubview(pickerView)
        
        pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
        
        return (viewController, pickerView)
    }
    
    private func setupAlertPicker(viewController: UIViewController, pickerView: UIPickerView, selectionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "Select Cateogry", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = categoryButton
        alert.popoverPresentationController?.sourceRect = categoryButton.bounds
        alert.setValue(viewController, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in }))
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: selectionHandler))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - PICKERVIEW SETUP
extension ProfileInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return categories.count
        } else if pickerView.tag == 1 {
            return payments.count
        } else {
            return powers.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        
        if pickerView.tag == 0 {
            label.text = categories[row]
        } else if pickerView.tag == 1 {
            label.text = payments[row]
        } else {
            label.text = "\(powers[row])"
        }
        
        label.sizeToFit()
        return label
    }
}

