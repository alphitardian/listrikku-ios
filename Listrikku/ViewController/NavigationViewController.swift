//
//  NavigationViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let onboardingStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
        let onboardingViewController = onboardingStoryboard.instantiateViewController(withIdentifier: "Greeting") as! GreetingViewController
        
        let isUserAvailable = onboardingViewModel.loadUser()
        if isUserAvailable != nil {
            self.setViewControllers([mainViewController], animated: true)
        } else {
            self.setViewControllers([onboardingViewController], animated: true)
        }
    }
}
