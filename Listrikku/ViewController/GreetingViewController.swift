//
//  GreetingViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import UIKit

class GreetingViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomView()
        setCustomLabel()
    }
    
    
}

//MARK: - Set Custom View & Accessibility
extension GreetingViewController {
    private func setCustomLabel() {
        greetingLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        appNameLabel.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
    }
    
    private func setCustomView() {
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
        nextButton.tintColor = appPrimaryColor()
    }
}
