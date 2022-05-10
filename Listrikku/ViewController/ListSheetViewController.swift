//
//  ListSheetViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 09/05/22.
//

import UIKit

class ListSheetViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let listViewModel: ListViewModel = ListViewModel.sharedInstance
    private var data: [Electronic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.data = listViewModel.loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.data = listViewModel.loadItems()
        self.tableView.reloadData()
        
        let bill = listViewModel.getUserNextBill()
        dateLabel.text = bill?.date?.getFullDate()
        
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill?.billEstimation ?? 0.0)
        billLabel.text = "Rp. \(formattedBill ?? "0.0")"
    }
    
    @objc private func closeModal() {
        self.dismiss(animated: true)
    }
}

extension ListSheetViewController: UITableViewDelegate {
    // Default table view
}

extension ListSheetViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.data {
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataSheetTableViewCell
        
        if let data = self.data {
            let item = data[indexPath.row]
            cell.nameLabel.text = "\(item.name ?? "") (\(item.power ?? "0")W)"
            cell.quantityLabel.text = "Qty: \(item.quantity ?? 0)"
        }
        
        return cell
    }
}
