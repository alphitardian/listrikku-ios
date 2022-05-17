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
    
    private let reminderViewModel: ReminderViewModel = ReminderViewModel()
    private var pickedDate: Date?
    var modalDelegate: ModalControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tambah Pengingat"
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simpan", style: .done, target: self, action: #selector(saveReminder))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Tutup", style: .plain, target: self, action: #selector(closeModal))
        
        nominalTextField.delegate = self
        messageTextField.delegate = self

        // Tap anywhere on screen to close keyboard
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tapToDismiss)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAccessibility()
        setTextfieldPlaceholderColor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modalDelegate?.modalWillDisappear(self)
    }
    
    @IBAction func onDatePickerChanged(_ sender: UIDatePicker) {
        pickedDate = datePicker.date
        print(datePicker.date)
    }
    
    @objc private func saveReminder() {
        let data = Bill(id: UUID(), billEstimation: Double(nominalTextField.text ?? "0.0"), date: pickedDate ?? Date())
        reminderViewModel.saveUserBill(data: data)
        reminderViewModel.scheduleReminder(date: pickedDate ?? Date(), message: messageTextField.text ?? "")
        self.dismiss(animated: true)
    }
    
    @objc private func closeModal() {
        self.dismiss(animated: true)
    }
    
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
}

//MARK: - Animate view when the keyboard is blocking textfield
extension AddReminderViewController: UITextFieldDelegate {

    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
