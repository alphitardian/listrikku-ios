//
//  InputDataViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import UIKit

class InputDataViewController: UIViewController {
    
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var durationButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var modalDelegate: ModalControllerDelegate?
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedPower = 0
    var selectedDuration = 0
    let powers = [450, 900, 1300, 2200]
    let durations = [1, 4, 8, 16, 24]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modalDelegate?.modalWillDisappear(self)
    }
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        print(nameTextField.text)
        print(powerButton.titleLabel?.text)
        print(durationButton.titleLabel?.text)
        self.dismiss(animated: true)
    }
    
    /// Use tag to specify pickerview
    /// Tag 0 = power
    /// Tag 1 = duration
    
    @IBAction func onPowerClick(_ sender: UIButton) {
        let powerPickerView = setupPickerView(tag: 0)
        setupAlertPicker(viewController: powerPickerView.0, pickerView: powerPickerView.1) { UIAlertAction in
            self.selectedPower = powerPickerView.1.selectedRow(inComponent: 0)
            let selected = self.powers[self.selectedPower]
            self.powerButton.setTitle("\(selected)", for: .normal)
        }
    }
    
    @IBAction func onDurationClick(_ sender: UIButton) {
        let durationPickerView = setupPickerView(tag: 1)
        setupAlertPicker(viewController: durationPickerView.0, pickerView: durationPickerView.1) { UIAlertAction in
            self.selectedDuration = durationPickerView.1.selectedRow(inComponent: 0)
            let selected = self.durations[self.selectedDuration]
            self.durationButton.setTitle("\(selected)", for: .normal)
        }
    }
    
    private func setupPickerView(tag: Int) -> (UIViewController, UIPickerView) {
        let viewController = UIViewController()
        viewController.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = tag
        
        viewController.view.addSubview(pickerView)
        
        pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
        
        return (viewController, pickerView)
    }
    
    private func setupAlertPicker(viewController: UIViewController, pickerView: UIPickerView, selectionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "Pilih Salah Satu", message: "", preferredStyle: .actionSheet)
        alert.setValue(viewController, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Kembali", style: .cancel, handler: { UIAlertAction in }))
        alert.addAction(UIAlertAction(title: "Pilih", style: .default, handler: selectionHandler))
        self.present(alert, animated: true, completion: nil)
    }
}

extension InputDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return powers.count
        } else {
            return durations.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        
        if pickerView.tag == 0 {
            label.text = "\(powers[row])"
        } else {
            label.text = "\(durations[row])"
        }
        
        label.sizeToFit()
        return label
    }
}
