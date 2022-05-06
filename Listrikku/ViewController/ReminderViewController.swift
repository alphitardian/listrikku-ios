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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Reminder"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addReminder))
        
        backgroundViewLastBill.layer.cornerRadius = 8
        backgroundViewNextBill.layer.cornerRadius = 8
        
        setUserLastBill()
        setUserNextBill()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUserLastBill()
        setUserNextBill()
    }
    
    @objc private func addReminder() {
        
    }
    
    private func setUserLastBill() {
        let bill = reminderViewModel.getUserLastBill()
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill?.billEstimation ?? 0.0)
        lastBillLabel.text = "Rp. \(formattedBill ?? "0.0")"
    }
    
    private func setUserNextBill() {
        let bill = reminderViewModel.getUserNextBill()
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill?.billEstimation ?? 0.0)
        nextBillLabel.text = "Rp. \(formattedBill ?? "0.0")"
        nextBillDateLabel.text = bill?.date?.getFullDate()
    }
}
