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
    @IBOutlet weak var greetingLabelOne: UILabel!
    @IBOutlet weak var greetingLabelTwo: UILabel!
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        nextButton.tintColor = appPrimaryColor()
        
        nameTextField.addTarget(self, action: #selector(didTextFieldChange(_:)), for: .editingChanged)
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Tulis Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "textfieldPlaceholderColor")!]
        )
        nameTextFieldErrorLabel.isHidden = true
        
        setCustomLabel()
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
    
    private func setCustomLabel() {
        greetingLabelOne.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        greetingLabelTwo.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
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
