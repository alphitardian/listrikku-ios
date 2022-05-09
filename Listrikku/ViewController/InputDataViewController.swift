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
    var isUpdateData: Bool?
    var avaliableData: Electronic?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Input Data"
        self.navigationController?.navigationBar.tintColor = appPrimaryColor()
        objectImage.contentMode = .scaleAspectFill
        objectImage.layer.cornerRadius = 8
        
        nameTextField.delegate = self
        quantityTextField.delegate = self
        powerTextField.delegate = self
        durationTextField.delegate = self
        
        // Tap anywhere on screen to close keyboard
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tapToDismiss)
        
        if isUpdateData ?? false {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hapus", style: .plain, target: self, action: #selector(deleteItem))
            
            nameTextField.text = avaliableData?.name
            quantityTextField.text = "\(avaliableData?.quantity ?? 1)"
            powerTextField.text = avaliableData?.power
            durationTextField.text = avaliableData?.duration
            objectImage.image = UIImage(data: (avaliableData?.image)!)
        }
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
            image: objectImage.image?.jpegData(compressionQuality: 0.5) // Half resolution
        )
        
        if isUpdateData ?? false {
            listViewModel?.updateItem(id: self.avaliableData?.id ?? UUID(), data: data)
        } else {
            listViewModel?.saveItem(data: data)
        }
        
        self.dismiss(animated: true)
    }
    
    @objc private func deleteItem() {
        listViewModel?.deleteItem(id: self.avaliableData?.id ?? UUID())
        self.dismiss(animated: true)
    }
}

extension InputDataViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBAction func onCameraClick(_ sender: UIButton) {
        DispatchQueue.main.async {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            self.present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        objectImage.image = pickedImage
        objectImage.contentMode = .scaleAspectFill
        objectImage.layer.cornerRadius = 8
        
        guard let ciImage = CIImage(image: pickedImage) else {
            fatalError("Not able to convert UIImage to CIImage")
        }
        detectImage(image: ciImage)
        
        picker.dismiss(animated: true)
    }
    
    private func detectImage(image: CIImage) {
        ImageDetectionHelper.detectImage(image: image) { result in
            let name = result.identifier
            self.nameTextField.text = name
        }
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
