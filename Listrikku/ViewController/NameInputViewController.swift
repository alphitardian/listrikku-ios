//
//  NameInputViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 02/05/22.
//

import UIKit

class NameInputViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel.sharedInstance
    
    @IBAction func onNextClick(_ sender: UIButton) {
        if let name = nameTextField.text {
            onboardingViewModel.setUserName(name: name)
        }
    }
}
