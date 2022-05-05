//
//  EstimationResultViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 05/05/22.
//

import UIKit

class EstimationResultViewController: UIViewController {

    @IBOutlet weak var estimationLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var estimationResult: String?
    var modalDelegate: ModalControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        estimationLabel.text = estimationResult
        modalDelegate?.modalWillDisappear(self)
    }
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
