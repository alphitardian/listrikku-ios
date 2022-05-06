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
    
    var modalDelegate: ModalControllerDelegate?
    
    private let listViewModel: ListViewModel = ListViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultSegmentView()
        setPostpaidEstimation()
        modalDelegate?.modalWillDisappear(self)
    }
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let bill = listViewModel.loadUserBills().first?.billEstimation
            let data = Bill(id: UUID(), billEstimation: bill, date: Date())
            listViewModel.saveUserBill(data: data)
        } else {
            let bill = listViewModel.calculatePrepaidBillEstimation().cost
            let powerPerDay = listViewModel.calculatePrepaidBillEstimation().kwh
            let prepaidDuration = listViewModel.calculatePrepaidDuration(cost: bill, kwh: powerPerDay)
            let today = Date()
            let calendar = Calendar.current.date(byAdding: .day, value: prepaidDuration, to: today)
            let data = Bill(id: UUID(), billEstimation: Double(bill), date: calendar)
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
        let bill = listViewModel.loadUserBills().first?.billEstimation
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill ?? 0.0)
        estimationLabel.text = "Rp. \(formattedBill ?? "0.0")"
        
        prepaidViewContainer.isHidden = true
    }
    
    private func setPrepaidEstimation() {
        let bill = listViewModel.calculatePrepaidBillEstimation().cost
        let powerPerDay = listViewModel.calculatePrepaidBillEstimation().kwh
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: Double(bill) ?? 0.0)
        estimationLabel.text = "Rp. \(formattedBill ?? "0.0")"
        
        let prepaidDuration = listViewModel.calculatePrepaidDuration(cost: bill, kwh: powerPerDay)
        prepaidDurationLabel.text = "\(prepaidDuration) days"
        
        prepaidViewContainer.isHidden = false
    }
    
    private func setDefaultSegmentView() {
        let user = listViewModel.getUserProfile()
        
        if user?.paymentMethod == "Pascabayar" {
            self.segmentedControl.selectedSegmentIndex = 0
        } else {
            self.segmentedControl.selectedSegmentIndex = 1
        }
    }
}
