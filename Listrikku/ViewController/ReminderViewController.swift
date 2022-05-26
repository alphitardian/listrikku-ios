//
//  ReminderViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 29/04/22.
//

import UIKit

class ReminderViewController: UIViewController {

    @IBOutlet weak var backgroundViewLastBill: UIView!
    @IBOutlet weak var backgroundViewNextBill: UIView!
    @IBOutlet weak var lastBillLabel: UILabel!
    @IBOutlet weak var nextBillDateLabel: UILabel!
    @IBOutlet weak var nextBillLabel: UILabel!
    
    private let reminderViewModel: ReminderViewModel = ReminderViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserLastBill()
        setUserNextBill()
        setCustomView()
    }
    
    private func setUserLastBill() {
        let bill = reminderViewModel.getUserLastBill()
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill?.billEstimation ?? 0.0)
        lastBillLabel.text = "Rp. \(formattedBill ?? "0.0")"
        
        lastBillLabel.accessibilityLabel = "Biaya tagihan sebelumnya"
        lastBillLabel.accessibilityHint = "Biaya tagihan sebelumnya sebesar \(formattedBill ?? "0") rupiah"
    }
    
    private func setUserNextBill() {
        let bill = reminderViewModel.getUserNextBill()
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill?.billEstimation ?? 0.0)
        nextBillLabel.text = "Rp. \(formattedBill ?? "0.0")"
        nextBillDateLabel.text = bill?.date?.getFullDate()
        
        nextBillLabel.accessibilityLabel = "Biaya tagihan selanjutnya"
        nextBillLabel.accessibilityHint = "Biaya tagihan selanjutnya sebesar \(formattedBill ?? "0") rupiah"
        nextBillDateLabel.accessibilityLabel = "Tenggat waktu tagihan selanjutnya"
        nextBillDateLabel.accessibilityHint = "Anda harus membayar tagihan sebelum tanggal \(bill?.date?.getFullDate() ?? "")"
    }
}

//MARK: - Modal Controller Delegate
extension ReminderViewController: ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T) {
        setUserNextBill()
        setUserLastBill()
    }
}

//MARK: - Set Custom View & Accessibility
extension ReminderViewController {
    private func setCustomView() {
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
        
        backgroundViewLastBill.layer.cornerRadius = 8
        backgroundViewNextBill.layer.cornerRadius = 8
        
        lastBillLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        nextBillDateLabel.font = UIFont.preferredFont(for: .title2, weight: .semibold)
        nextBillLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
    }
    
    private func setAccessibility() {
        self.navigationItem.accessibilityLabel = "Anda berada di halaman \(self.title ?? "")"
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Tombol tambah pengingat"
        self.navigationItem.rightBarButtonItem?.accessibilityHint = "Tombol tambah pengingat digunakan untuk menambah pengingat dengan tanggal yang anda tentukan"
    }
}

//MARK: - Segue Preparation
extension ReminderViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Open add reminder screen
        if segue.identifier == Constant.SegueNavigation.goToAddReminder {
            if let navigationController = segue.destination as? UINavigationController {
                if let viewController = navigationController.viewControllers.first as? AddReminderViewController {
                    viewController.modalDelegate = self
                    viewController.reminderViewModel = reminderViewModel
                }
            }
        }
        
        // Open bill detail
        if segue.identifier == Constant.SegueNavigation.goToListSheet {
            if let navigationController = segue.destination as? UINavigationController {
                if let sheet = navigationController.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                }
            }
        }
    }
}
