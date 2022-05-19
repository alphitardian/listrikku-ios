//
//  EstimationResultViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 05/05/22.
//

import UIKit

class EstimationResultViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var estimationLabel: UILabel!
    @IBOutlet weak var prepaidViewContainer: UIStackView!
    @IBOutlet weak var prepaidDurationLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var modalDelegate: ModalControllerDelegate?
    
    private let listViewModel: ListViewModel = ListViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Estimasi"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeModal))

        setDefaultSegmentView()
        modalDelegate?.modalWillDisappear(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.layer.cornerRadius = 8
        setCustomLabel()
    }
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let bill = listViewModel.calculatePostpaidBillEstimation()
            let data = Bill(id: UUID(), billEstimation: Double(bill), date: Date())
            
            listViewModel.scheduleReminder(date: Date(), message: "")
            listViewModel.saveUserBill(data: data)
        } else {
            let bill = listViewModel.calculatePrepaidBillEstimation().cost
            let powerPerDay = listViewModel.calculatePrepaidBillEstimation().kwh
            let prepaidDuration = listViewModel.calculatePrepaidDuration(cost: bill, kwh: powerPerDay)
            
            let today = Date()
            let calendar = Calendar.current.date(byAdding: .day, value: prepaidDuration, to: today)
            let data = Bill(id: UUID(), billEstimation: Double(bill), date: calendar)
            if let calendar = calendar {
                listViewModel.scheduleReminder(date: calendar, message: "")
            }
            
            listViewModel.saveUserBill(data: data)
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func onSegmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            setPostpaidEstimation()
        } else {
            setPrepaidEstimation()
        }
    }
    
    private func setPostpaidEstimation() {
        let bill = listViewModel.calculatePostpaidBillEstimation()
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: Double(bill)?.rounded() ?? 0.0)
        estimationLabel.text = "Rp. \(formattedBill ?? "0.0")"
        
        setAccessibility(estimation: formattedBill ?? "0", duration: 0)
        
        prepaidViewContainer.isHidden = true
    }
    
    private func setPrepaidEstimation() {
        let bill = listViewModel.calculatePrepaidBillEstimation().cost
        let powerPerDay = listViewModel.calculatePrepaidBillEstimation().kwh
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: Double(bill) ?? 0.0)
        estimationLabel.text = "Rp. \(formattedBill ?? "0.0")"
        
        let prepaidDuration = listViewModel.calculatePrepaidDuration(cost: bill, kwh: powerPerDay)
        prepaidDurationLabel.text = "\(prepaidDuration) hari"
        
        setAccessibility(estimation: formattedBill ?? "0", duration: prepaidDuration)
        
        prepaidViewContainer.isHidden = false
    }
    
    private func setDefaultSegmentView() {
        let user = listViewModel.getUserProfile()
        
        if user?.paymentMethod == "Pascabayar" {
            self.segmentedControl.selectedSegmentIndex = 0
            setPostpaidEstimation()
        } else {
            self.segmentedControl.selectedSegmentIndex = 1
            setPrepaidEstimation()
        }
    }
    
    private func setCustomLabel() {
        estimationLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        prepaidDurationLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
    }
    
    private func setAccessibility(estimation: String, duration: Int) {
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Tombol tutup"
        self.navigationItem.rightBarButtonItem?.accessibilityHint = "Tombol tutup digunakan untuk menutup halaman input data"
        
        estimationLabel.accessibilityLabel = "Biaya tagihan listrik"
        estimationLabel.accessibilityHint = "Biaya tagihan listrik yang harus dibayar adalah \(estimation) rupiah"
        
        prepaidDurationLabel.accessibilityLabel = "Durasi penggunaan listrik"
        prepaidDurationLabel.accessibilityHint = "Listrik dapat bertahan selama \(duration) hari"
    }
    
    @objc private func closeModal() {
        self.dismiss(animated: true)
    }
}
