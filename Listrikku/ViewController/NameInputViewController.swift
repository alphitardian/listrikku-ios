//
//  NameInputViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 02/05/22.
//

import UIKit

class NameInputViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        nextButton.tintColor = appPrimaryColor()
    }
    
    @IBAction func onNextClick(_ sender: UIButton) {
        if let name = nameTextField.text {
            onboardingViewModel.setUserName(name: name)
        }
    }
}

extension NameInputViewController: UITextFieldDelegate {
    // close keyboard when user tap return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
