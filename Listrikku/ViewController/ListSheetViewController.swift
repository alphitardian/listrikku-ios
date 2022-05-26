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
        
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.data = listViewModel.loadItems()
        self.tableView.reloadData()
        
        setUserNextBill()
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func setUserNextBill() {
        let bill = listViewModel.getUserNextBill()
        dateLabel.text = bill?.date?.getFullDate()
        
        let formattedBill = NumberFormatterHelper.convertToRupiah(value: bill?.billEstimation ?? 0.0)
        billLabel.text = "Rp. \(formattedBill ?? "0.0")"
        
        setAccessibility(nextBillNominal: formattedBill ?? "0")
    }
}

//MARK: TableView DataSource
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellID.dataCell, for: indexPath) as! DataSheetTableViewCell
        
        if let data = self.data {
            let item = data[indexPath.row]
            cell.nameLabel.text = "\(item.name ?? "") (\(item.power ?? "0")W)"
            cell.quantityLabel.text = "Qty: \(item.quantity ?? 0)"
            cell.accessibilityLabel = "\(item.name ?? "") dengan jumlah \(item.quantity ?? 0)"
        }
        
        return cell
    }
}

//MARK: Set Custom UI & Accessibility
extension ListSheetViewController {
    private func setAccessibility(nextBillNominal: String) {
        dateLabel.accessibilityHint = "Anda harus membayar tagihan pada tanggal \(dateLabel.text ?? "")"
        billLabel.accessibilityHint = "Biaya tagihan listrik yang harus dibayar selanjutnya sebesar \(nextBillNominal) rupiah"
        
        dateLabel.font = UIFont.preferredFont(for: .title2, weight: .semibold)
        billLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Tombol tutup"
        self.navigationItem.rightBarButtonItem?.accessibilityHint = "Tombol tutup digunakan untuk menutup halaman input data"
    }
}
