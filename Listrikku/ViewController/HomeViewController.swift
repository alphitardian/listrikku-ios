//
//  HomeViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 29/04/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var backgroundViewNextBill: UIView!
    @IBOutlet weak var backgroundViewSetBill: UIView!
    @IBOutlet weak var nextBillLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    private let homeViewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.registerReminder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserNextBill()
        setCustomView()
    }
    
    private func setUserNextBill() {
        let bill = homeViewModel.loadUserBills().last?.billEstimation
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill ?? 0.0)
        nextBillLabel.text = "Rp. \(formattedBill ?? "0.0")"
        setAccessibility(nextBillNominal: formattedBill ?? "0")
    }
}

//MARK: - Modal Controller Delegate Implementation
extension HomeViewController: ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T) {
        // Update data when modal closed
    }
}

//MARK: - Set Custom UI & Accessibility
extension HomeViewController {
    private func setAccessibility(nextBillNominal: String) {
        self.navigationItem.accessibilityLabel = "Anda berada di halaman \(self.title ?? "")"
        
        nextBillLabel.accessibilityHint = "Biaya tagihan listrik yang harus dibayar selanjutnya sebesar \(nextBillNominal) rupiah"
        
        nextBillLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        startLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
    }
    
    private func setCustomView() {
        backgroundViewNextBill.layer.cornerRadius = 8
        backgroundViewSetBill.layer.cornerRadius = 8
    }
}

//MARK: - Segue Preparation
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Open bill detail
        if segue.identifier == Constant.SegueNavigation.goToListSheet {
            if let navigationController = segue.destination as? UINavigationController {
                if let sheet = navigationController.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                }
            }
        }
        
        // Open input data screen
        if segue.identifier == Constant.SegueNavigation.goToInput {
            if let navigationController = segue.destination as? UINavigationController {
                if let viewController = navigationController.viewControllers.first as? InputDataViewController {
                    viewController.modalDelegate = self
                }
            }
        }
    }
}
