//
//  ListViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 29/04/22.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var calculateButton: UIButton!
    
    private let listViewModel: ListViewModel = ListViewModel()
    private var data: [Electronic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Your List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        
        self.data = listViewModel.load()
    }
    
    @objc private func addItem() {
        let storyboard = UIStoryboard(name: "ListData", bundle: nil)
        let addViewController = storyboard.instantiateViewController(withIdentifier: "Add") as? InputDataViewController
        if let addViewController = addViewController {
            addViewController.listViewModel = self.listViewModel
            addViewController.modalDelegate = self
            self.navigationController?.present(addViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        // Calculate Bill
        print("Calculate")
        calculateBillEstimation()
    }
    
    private func calculateBillEstimation() {
        if let data = data {
            var result = 0
            for value in data {
                let power = Int(value.power ?? "0") ?? 0
                let duration = Int(value.duration ?? "0") ?? 0
                let total = power * duration
                result += total
            }
            print("result: \(result)")
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show Detail
        print("tapped")
    }
}

/// TableView Boilerplate
extension ListViewController: UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataTableViewCell
        cell.cellBackgroundView?.layer.cornerRadius = 8
        
        if let data = self.data {
            cell.powerLabel?.text = data[indexPath.row].power
            cell.objectLabel?.text = data[indexPath.row].name
        }
        
        return cell
    }
}

extension ListViewController: ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T) {
        // Update List after input / update data
        self.data = listViewModel.load()
        self.listTableView.reloadData()
    }
}
