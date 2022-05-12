//
//  ProfileInputViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 28/04/22.
//

import UIKit

class ProfileInputViewController: UIViewController {

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.tintColor = appPrimaryColor()
    }
    
    /// Use tag to specify pickerview
    /// Tag 0 = category
    /// Tag 1 = payment
    /// Tag 2 = power
    
    @IBAction func onCategoryClick(_ sender: UIButton) {
        let categoryPickerView = setupPickerView(tag: 0)
        setupAlertPicker(viewController: categoryPickerView.controller, pickerView: categoryPickerView.view) { UIAlertAction in
            self.onboardingViewModel.setCategory(at: categoryPickerView.view.selectedRow(inComponent: 0))
            let selected = self.onboardingViewModel.category[self.onboardingViewModel.selectedCategory ?? 0]
            self.categoryButton.setTitle(selected, for: .normal)
        }
    }
    
    @IBAction func onPaymentClick(_ sender: UIButton) {
        let paymentPickerView = setupPickerView(tag: 1)
        setupAlertPicker(viewController: paymentPickerView.controller, pickerView: paymentPickerView.view) { UIAlertAction in
            self.onboardingViewModel.setSelectedPaymentMethod(at: paymentPickerView.view.selectedRow(inComponent: 0))
            let selected = self.onboardingViewModel.payment[self.onboardingViewModel.selectedPaymentMethod ?? 0]
            self.paymentButton.setTitle(selected, for: .normal)
        }
    }
    
    @IBAction func onPowerClick(_ sender: UIButton) {
        let powerPickerView = setupPickerView(tag: 2)
        setupAlertPicker(viewController: powerPickerView.controller, pickerView: powerPickerView.view) { UIAlertAction in
            self.onboardingViewModel.setSelectedPower(at: powerPickerView.view.selectedRow(inComponent: 0))
            let selected = self.onboardingViewModel.power[self.onboardingViewModel.selectedPower ?? 0]
            self.powerButton.setTitle("\(selected)", for: .normal)
        }
    }
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        if onboardingViewModel.selectedCategory != nil && onboardingViewModel.selectedPower != nil && onboardingViewModel.selectedPaymentMethod != nil {
            onboardingViewModel.saveUser()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
            self.navigationController?.pushViewController(mainViewController, animated: true)
        } else {
            let alert = UIAlertController(title: "Perhatian", message: "Pilih profil yang sesuai dengan kebutuhan anda untuk melanjutkan.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
}

//MARK: - PickerView Delegate & DataSource
extension ProfileInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return onboardingViewModel.category.count
        } else if pickerView.tag == 1 {
            return onboardingViewModel.payment.count
        } else {
            return onboardingViewModel.power.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UI_SCREEN_WIDTH, height: 30))
        
        if pickerView.tag == 0 {
            label.text = onboardingViewModel.category[row]
        } else if pickerView.tag == 1 {
            label.text = onboardingViewModel.payment[row]
        } else {
            label.text = onboardingViewModel.power[row]
        }
        
        label.sizeToFit()
        return label
    }
}

//MARK: - Custom Picker Setup
extension ProfileInputViewController {
    private func setupPickerView(tag: Int) -> (controller: UIViewController, view: UIPickerView) {
        let viewController = UIViewController()
        viewController.preferredContentSize = CGSize(width: UI_SCREEN_WIDTH, height: UI_SCREEN_HEIGHT)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: UI_SCREEN_WIDTH, height: UI_SCREEN_HEIGHT))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = tag
        
        viewController.view.addSubview(pickerView)
        
        pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
        
        return (controller: viewController, view: pickerView)
    }
    
    private func setupAlertPicker(viewController: UIViewController, pickerView: UIPickerView, selectionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "Pilih Salah Satu", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = categoryButton
        alert.popoverPresentationController?.sourceRect = categoryButton.bounds
        alert.setValue(viewController, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Kembali", style: .cancel, handler: { UIAlertAction in }))
        alert.addAction(UIAlertAction(title: "Pilih", style: .default, handler: selectionHandler))
        self.present(alert, animated: true, completion: nil)
    }
}

