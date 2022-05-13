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
    private let listViewModel: ListViewModel = ListViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Home"
        backgroundViewNextBill.layer.cornerRadius = 8
        backgroundViewSetBill.layer.cornerRadius = 8
        
        setUserNextBill()
        
        homeViewModel.registerReminder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set accessibility in navigation bar
        self.navigationItem.accessibilityLabel = "Anda berada di halaman \(self.title ?? "")"
        
        setUserNextBill()
    }
    
    @IBAction func onBillDetailClick(_ sender: UIButton) {
        // Open bill detail
        let storyboard = UIStoryboard(name: "ListData", bundle: nil)
        let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "List") as! ListSheetViewController
        if let sheet = welcomeViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        self.navigationController?.present(welcomeViewController, animated: true)
    }
    
    @IBAction func onAddItemClick(_ sender: UIButton) {
        // Open add item
        let storyboard = UIStoryboard(name: "ListData", bundle: nil)
        let addViewController = storyboard.instantiateViewController(withIdentifier: "Add") as? InputDataViewController
        if let addViewController = addViewController {
            addViewController.listViewModel = listViewModel
            addViewController.modalDelegate = self
            let navigationController: UINavigationController = UINavigationController(rootViewController: addViewController)
            navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
    }
    
    private func setUserNextBill() {
        let bill = homeViewModel.loadUserBills().last?.billEstimation
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill ?? 0.0)
        nextBillLabel.text = "Rp. \(formattedBill ?? "0.0")"
        setAccessibility(nextBillNominal: formattedBill ?? "0")
    }
    
    private func setAccessibility(nextBillNominal: String) {
        nextBillLabel.accessibilityHint = "Biaya tagihan listrik yang harus dibayar selanjutnya sebesar \(nextBillNominal) rupiah"
        
        nextBillLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        startLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
    }
}

extension HomeViewController: ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T) {
        print(homeViewModel.loadUserBills())
    }
}
