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
    
    private let listViewModel: ListViewModel = ListViewModel.sharedInstance
    private var data: [Electronic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Daftar Barang"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tambah", style: .plain, target: self, action: #selector(addItem))
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        
        self.data = listViewModel.loadItems()
        if listViewModel.loadItems().isEmpty {
            calculateButton.isHidden = true
        } else {
            calculateButton.isHidden = false
        }
        
        setPrimaryButtonShadow(for: calculateButton)
        calculateButton.tintColor = appPrimaryColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.data = listViewModel.loadItems()
        self.listTableView.reloadData()
    }
    
    @objc private func addItem() {
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
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ListData", bundle: nil)
        let resultViewController = storyboard.instantiateViewController(withIdentifier: "Result") as? EstimationResultViewController
        if let resultViewController = resultViewController {
            resultViewController.modalDelegate = self
            self.navigationController?.present(resultViewController, animated: true)
        }
    }
}

//MARK: - TableView Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show Detail
        if let data = self.data {
            let index = indexPath.row
            let storyboard = UIStoryboard(name: "ListData", bundle: nil)
            let addViewController = storyboard.instantiateViewController(withIdentifier: "Add") as? InputDataViewController
            if let addViewController = addViewController {
                addViewController.listViewModel = listViewModel
                addViewController.modalDelegate = self
                addViewController.isUpdateData = true // For update data
                addViewController.avaliableData = data[index]
                let navigationController: UINavigationController = UINavigationController(rootViewController: addViewController)
                navigationController.navigationBar.prefersLargeTitles = true
                self.navigationController?.present(navigationController, animated: true, completion: nil)
            }
        }
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
            cell.powerLabel?.text = "\(data[indexPath.row].power ?? "0") Watt"
            cell.objectLabel?.text = data[indexPath.row].name
            cell.objectImage.image = UIImage(data: data[indexPath.row].image!)
            cell.objectImage.contentMode = .scaleAspectFill
            cell.objectImage.layer.cornerRadius = 8
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
        
        if listViewModel.loadItems().isEmpty {
            calculateButton.isHidden = true
        } else {
            calculateButton.isHidden = false
        }
    }
}
