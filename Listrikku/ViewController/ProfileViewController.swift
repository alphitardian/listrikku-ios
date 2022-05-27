//
//  ProfileViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 27/05/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var powerButton: UIButton!
    
    var homeViewModel: HomeViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel?.loadUserProfile()
        loadUser()
        setCustomView()
    }
    
    @IBAction func onCategoryClick(_ sender: Any) {
        let categoryPickerView = setupPickerView(tag: 0, sender: self)
        setupAlertPicker(
            messageDetail: homeViewModel?.loadComponentDetail(tag: 0) ?? "",
            viewController: categoryPickerView.controller,
            pickerView: categoryPickerView.view, sender: self
        ) { UIAlertAction in
            self.homeViewModel?.setCategory(at: categoryPickerView.view.selectedRow(inComponent: 0))
            let selected = self.homeViewModel?.category[self.homeViewModel?.selectedCategory ?? 0]
            self.categoryButton.setTitle(selected, for: .normal)
        }
    }
    
    @IBAction func onPaymentClick(_ sender: Any) {
        let paymentPickerView = setupPickerView(tag: 1, sender: self)
        setupAlertPicker(
            messageDetail: homeViewModel?.loadComponentDetail(tag: 1) ?? "",
            viewController: paymentPickerView.controller,
            pickerView: paymentPickerView.view,
            sender: self
        ) { UIAlertAction in
            self.homeViewModel?.setSelectedPaymentMethod(at: paymentPickerView.view.selectedRow(inComponent: 0))
            let selected = self.homeViewModel?.payment[self.homeViewModel?.selectedPaymentMethod ?? 0]
            self.paymentButton.setTitle(selected, for: .normal)
        }
    }
    
    @IBAction func onPowerClick(_ sender: Any) {
        let powerPickerView = setupPickerView(tag: 2, sender: self)
        setupAlertPicker(
            messageDetail: homeViewModel?.loadComponentDetail(tag: 2) ?? "",
            viewController: powerPickerView.controller,
            pickerView: powerPickerView.view,
            sender: self
        ) { UIAlertAction in
            self.homeViewModel?.setSelectedPower(at: powerPickerView.view.selectedRow(inComponent: 0))
            let selected = self.homeViewModel?.power[self.homeViewModel?.selectedPower ?? 0]
            self.powerButton.setTitle(selected, for: .normal)
        }
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onUpdateClick(_ sender: Any) {
        homeViewModel?.updateUserProfile()
        self.dismiss(animated: true)
    }
    
    @IBAction func onDeleteClick(_ sender: UIButton) {
        homeViewModel?.deleteUserProfile()
        // Move to welcome screen
    }
    
    private func loadUser() {
        if let user = homeViewModel?.loadedUser {
            categoryButton.setTitle(user.category, for: .normal)
            paymentButton.setTitle(user.paymentMethod, for: .normal)
            powerButton.setTitle(user.power, for: .normal)
        }
    }
}

//MARK: - PickerView Delegate & DataSource
extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource, UIPickerViewAccessibilityDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return homeViewModel?.category.count ?? 0
        } else if pickerView.tag == 1 {
            return homeViewModel?.payment.count ?? 0
        } else {
            return homeViewModel?.power.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UI_SCREEN_WIDTH, height: 30))
        
        if pickerView.tag == 0 {
            label.text = homeViewModel?.category[row]
        } else if pickerView.tag == 1 {
            label.text = homeViewModel?.payment[row]
        } else {
            label.text = homeViewModel?.power[row]
        }
        
        label.font = UIFont.preferredFont(for: .body, weight: .regular)
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, accessibilityLabelForComponent component: Int) -> String? {
        return "Pilih salah satu nilai yang sesuai dengan kebutuhan anda"
    }
}

//MARK: - Set Custom View & Accessibility
extension ProfileViewController {
    private func setCustomView() {
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
    }
}
