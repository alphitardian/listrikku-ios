//
//  InputDataViewController.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 01/05/22.
//

import UIKit

class InputDataViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var powerTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var objectImage: UIImageView!
    
    var listViewModel: ListViewModel?
    var modalDelegate: ModalControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Input Data"
        objectImage.layer.cornerRadius = 8
        
        nameTextField.delegate = self
        quantityTextField.delegate = self
        powerTextField.delegate = self
        durationTextField.delegate = self
        
        // Tap anywhere on screen to close keyboard
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tapToDismiss)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modalDelegate?.modalWillDisappear(self)
    }
    
    @IBAction func onSaveClick(_ sender: UIButton) {
        let data = Electronic(
            id: UUID(),
            name: nameTextField.text,
            quantity: Int(quantityTextField.text ?? "1"),
            power: powerTextField.text,
            duration: durationTextField.text,
            image: objectImage.image?.pngData()
        )
        listViewModel?.saveItem(data: data)
        self.dismiss(animated: true)
    }
}

extension InputDataViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBAction func onCameraClick(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        objectImage.image = pickedImage
        objectImage.contentMode = .scaleAspectFill
        picker.dismiss(animated: true)
    }
}

//MARK: - Animate view when the keyboard is blocking textfield
extension InputDataViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }

    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }

    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // Move the text field in an animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.animate(withDuration: moveDuration) {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
            self.objectImage.isHidden = up
        }
    }
}
