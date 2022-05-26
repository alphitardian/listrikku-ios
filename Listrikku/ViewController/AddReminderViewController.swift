//
//  AddReminderViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 08/05/22.
//

import UIKit

class AddReminderViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nominalTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    private var pickedDate: Date?
    var reminderViewModel: ReminderViewModel?
    var modalDelegate: ModalControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap anywhere on screen to close keyboard
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tapToDismiss)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAccessibility()
        setTextfieldPlaceholderColor()
        setCustomView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modalDelegate?.modalWillDisappear(self)
    }
    
    @IBAction func onDatePickerChanged(_ sender: UIDatePicker) {
        pickedDate = datePicker.date
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
        let data = Bill(id: UUID(), billEstimation: Double(nominalTextField.text ?? "0.0"), date: pickedDate ?? Date())
        reminderViewModel?.saveUserBill(data: data)
        reminderViewModel?.scheduleReminder(date: pickedDate ?? Date(), message: messageTextField.text ?? "")
        self.dismiss(animated: true)
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//MARK: - Set Custom View & Accessibility
extension AddReminderViewController {
    private func setTextfieldPlaceholderColor() {
        nominalTextField.attributedPlaceholder = NSAttributedString(
            string: "Nominal (Rp)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "textfieldPlaceholderColor")!]
        )
        messageTextField.attributedPlaceholder = NSAttributedString(
            string: "Pesan (Opsional)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "textfieldPlaceholderColor")!]
        )
    }
    
    private func setAccessibility() {
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Tombol simpan"
        self.navigationItem.rightBarButtonItem?.accessibilityHint = "Tombol simpan digunakan untuk menyimpan data yang telah dimasukkan sebelumnya"
        
        self.navigationItem.leftBarButtonItem?.accessibilityLabel = "Tombol tutup"
        self.navigationItem.leftBarButtonItem?.accessibilityHint = "Tombol tutup digunakan untuk menutup halaman input data"
    }
    
    private func setCustomView() {
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
    }
}
