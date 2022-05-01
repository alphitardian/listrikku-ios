//
//  InputDataViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import UIKit

class InputDataViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var powerTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    var modalDelegate: ModalControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modalDelegate?.modalWillDisappear(self)
    }
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        let data = Electronic(name: nameTextField.text, power: powerTextField.text, duration: durationTextField.text, image: nil)
        DatabaseHelper.sharedInstance.saveUserItem(data: data)
        self.dismiss(animated: true)
    }
}
