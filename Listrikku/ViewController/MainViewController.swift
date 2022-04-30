//
//  ViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 28/04/22.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Show welcome
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "Welcome") as! WelcomeViewController
        self.navigationController?.present(welcomeViewController, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

