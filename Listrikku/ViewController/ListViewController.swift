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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Your List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
    }
    
    @objc private func addItem() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addViewController = storyboard.instantiateViewController(withIdentifier: "Add") as? InputDataViewController
        if let addViewController = addViewController {
            addViewController.modalDelegate = self
            self.navigationController?.present(addViewController, animated: true, completion: nil)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as! DataTableViewCell
        cell.cellBackgroundView?.layer.cornerRadius = 8
        cell.powerLabel?.text = "900"
        cell.objectLabel?.text = "TV 43"
        return cell
    }
}

extension ListViewController: ModalControllerDelegate {
    func modalWillDisappear<T>(_ modal: T) {
        // Update List after input / update data
        print("update list")
    }
}
