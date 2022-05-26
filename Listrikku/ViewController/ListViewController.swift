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
    @IBOutlet weak var isHiddenLabel: UILabel!
    
    private let listViewModel: ListViewModel = ListViewModel.sharedInstance
    private var data: [Electronic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAccessibility()
        fetchListData()
        setCustomView()
    }
    
    @IBAction func onAddItemClick(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constant.SegueNavigation.goToInput, sender: sender)
    }
    
    private func fetchListData() {
        DispatchQueue.main.async {
            self.data = self.listViewModel.loadItems()
            self.calculateButton.isHidden = self.listViewModel.loadItems().isEmpty
            self.isHiddenLabel.isHidden = !self.listViewModel.loadItems().isEmpty
            
            self.listTableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open input data screen
        performSegue(withIdentifier: Constant.SegueNavigation.goToInput, sender: indexPath)
    }
}

//MARK: - TableView DataSource
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellID.dataCell, for: indexPath) as! DataTableViewCell
        cell.cellBackgroundView?.layer.cornerRadius = 8
        
        if let data = self.data {
            cell.powerLabel?.text = "\(data[indexPath.row].power ?? "0") Watt"
            cell.objectLabel?.text = data[indexPath.row].name
            cell.objectImage.image = UIImage(data: data[indexPath.row].image!)
            
            // Setup accessibility
            cell.accessibilityLabel = "\(data[indexPath.row].name ?? "") dengan daya \(data[indexPath.row].power ?? "0")"
            cell.objectImage.accessibilityLabel = "Foto \(data[indexPath.row].name ?? "")"
        }
        
        return cell
    }
}

//MARK: - Modal Controller Delegate
extension ListViewController: ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T) {
        // Update List after input / update data
        fetchListData()
    }
}

//MARK: - Set Custom UI & Accessibility
extension ListViewController {
    private func setAccessibility() {
        // Set accessibility in navigation bar
        self.navigationItem.accessibilityLabel = "Anda berada di halaman \(self.title ?? "")"
        
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Tombol tambah barang"
        self.navigationItem.rightBarButtonItem?.accessibilityHint = "Tombol tambah barang digunakan untuk mulai menambahkan barang yang ingin dihitung"
    }
    
    private func setCustomView() {
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
        
        setPrimaryButtonShadow(for: calculateButton)
        calculateButton.tintColor = appPrimaryColor()
        calculateButton.isHidden = true
        isHiddenLabel.isHidden = true
    }
}

//MARK: - Segue Preparation
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Open input data screen
        if segue.identifier == Constant.SegueNavigation.goToInput {
            if let navigationController = segue.destination as? UINavigationController {
                if let viewController = navigationController.viewControllers.first as? InputDataViewController {
                    if let data = self.data {
                        viewController.modalDelegate = self
                        
                        // Check if it come from tableview or navbar
                        if let indexPath = sender as? IndexPath {
                            viewController.isUpdateData = true
                            viewController.avaliableData = data[indexPath.row]
                        }
                    }
                }
            }
        }
        
        // Open estimation screen
        if segue.identifier == Constant.SegueNavigation.goToEstimation {
            if let navigationController = segue.destination as? UINavigationController {
                if let viewController = navigationController.viewControllers.first as? EstimationResultViewController {
                    viewController.modalDelegate = self
                }
            }
        }
    }
}
