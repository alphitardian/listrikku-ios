//
//  WelcomeViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 30/04/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.tintColor = appPrimaryColor()
    }
    
    @IBAction func onCloseClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
