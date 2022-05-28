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
        nameTextFieldErrorLabel.isHidden = true
        
        setCustomLabel()
        setCustomView()
    }
    
    @IBAction func onTextFieldChange(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            nameTextFieldErrorLabel.isHidden = true
        }
    }
    
    @IBAction func onNextClick(_ sender: UIButton) {
        if let name = nameTextField.text {
            if name.isEmpty {
                nameTextFieldErrorLabel.isHidden = false
            } else {
                onboardingViewModel.setUserName(name: name)
                performSegue(withIdentifier: Constant.SegueNavigation.goToInputProfile, sender: self)
            }
        }
    }
}

//MARK: - Set Custom View & Accessibility
extension NameInputViewController {
    private func setCustomLabel() {
        greetingLabelOne.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        greetingLabelTwo.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
    }
    
    private func setCustomView() {
        self.navigationController?.isNavigationBarHidden = false
        nextButton.tintColor = appPrimaryColor()
        
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Tulis Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "textfieldPlaceholderColor")!]
        )
    }
}

//MARK: - Text Field Delegate
extension NameInputViewController: UITextFieldDelegate {
    // close keyboard when user tap return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextFieldErrorLabel.isHidden = true
    }
}
