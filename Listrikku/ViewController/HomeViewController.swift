//
//  HomeViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 29/04/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var backgroundViewNextBill: UIView!
    @IBOutlet weak var backgroundViewSetBill: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Home"
        backgroundViewNextBill.layer.cornerRadius = 8
        backgroundViewSetBill.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if false {
            // Show welcome
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "Welcome") as! WelcomeViewController
            self.navigationController?.present(welcomeViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onBillDetailClick(_ sender: UIButton) {
        // Open bill detail
    }
    
    @IBAction func onAddBillClick(_ sender: UIButton) {
        // Open add item
    }
}
