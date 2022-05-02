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
        
        self.data = listViewModel.loadItems()
    }
    
    @objc private func addItem() {
        let storyboard = UIStoryboard(name: "ListData", bundle: nil)
        let addViewController = storyboard.instantiateViewController(withIdentifier: "Add") as? InputDataViewController
        if let addViewController = addViewController {
            addViewController.listViewModel = listViewModel
            addViewController.modalDelegate = self
            self.navigationController?.present(addViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        // Calculate Bill
        print("Calculate")
        listViewModel.calculateBillEstimation()
    }
}

//MARK: - TableView Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show Detail
        print("tapped")
    }
}

//MARK: - TableView DataSrouce
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

//MARK: - Modal Controller Delegate
extension ListViewController: ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T) {
        // Update List after input / update data
        self.data = listViewModel.loadItems()
        self.listTableView.reloadData()
    }
}
