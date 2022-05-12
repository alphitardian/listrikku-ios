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
    @IBOutlet weak var nameTextFieldErrorLabel: UILabel!
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        nextButton.tintColor = appPrimaryColor()
        
        nameTextField.addTarget(self, action: #selector(didTextFieldChange(_:)), for: .editingChanged)
        nameTextFieldErrorLabel.isHidden = true
    }
    
    @IBAction func onNextClick(_ sender: UIButton) {
        if let name = nameTextField.text {
            if name.isEmpty {
                nameTextFieldErrorLabel.isHidden = false
            } else {
                onboardingViewModel.setUserName(name: name)
                
                let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                let profileInputViewController = storyboard.instantiateViewController(withIdentifier: "ProfileInput") as? ProfileInputViewController
                if let profileInputViewController = profileInputViewController {
                    self.navigationController?.pushViewController(profileInputViewController, animated: true)
                }
            }
        }
    }
}

extension NameInputViewController: UITextFieldDelegate {
    // close keyboard when user tap return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextFieldErrorLabel.isHidden = true
    }
    
    @objc private func didTextFieldChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            nameTextFieldErrorLabel.isHidden = true
        }
    }
}
