//
//  UserProfileViewController.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

protocol UserProfileDelegate: AnyObject {
    func reloadUsersData()
}

class UserProfileViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var firstNameField: TextField!
    @IBOutlet private var lastNameField: TextField!
    @IBOutlet private var emailField: TextField!
    @IBOutlet private var confirmButton: UIButton!
    
    // MARK: - Components
    
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Variables
    
    var inputData: NewUser?
    weak var delegate: UserProfileDelegate?
    
    private var isValid: Bool {
        return emailField.validationError == nil && firstNameField.validationError == nil && lastNameField.validationError == nil
    }
    
    private var textFields: [TextField] {
        return [firstNameField, lastNameField, emailField]
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextFields()
        refreshButton()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        imagePicker.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Configurations
    
    private func updateTextFields() {
        if let inputData = inputData {
            firstNameField.text = inputData.firstName
            lastNameField.text = inputData.lastName
            emailField.text = inputData.email
        }
    }
    
    // MARK: - Actions
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let firstName = firstNameField.text,
            let lastName = lastNameField.text,
            let email = emailField.text else { return }
        
        let model = ApiService()
        let user = NewUser(firstName: firstName, lastName: lastName, email: email, avatarUrl: "")
        
        if inputData != nil {
            model.edit(user: user) { user in
                self.roteToListAfterSuccess()
            }
        } else {
            if let incorrectEmail = EmailValidator().validate(text: email) {
                emailField.validationError = incorrectEmail
            }

            if firstName.isEmpty {
                firstNameField.validationError = "First name must have at least one character"
            }

            if lastName.isEmpty {
                lastNameField.validationError = "Last name must have at least one character"
            }

            if isValid {
                model.create(user: user) { user in
                    self.roteToListAfterSuccess()
                }
            }
        }
    }
    
    private func roteToListAfterSuccess() {
        self.delegate?.reloadUsersData()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func refreshButton() {
        confirmButton.isEnabled = isFilled
        confirmButton.backgroundColor = confirmButton.isEnabled ? Asset.Colors.neonRed.color : Asset.Colors.slateGrey.color
    }
    
    private var hasChanges: Bool {
        guard let inputData = inputData else {
            return false
        }
        
        return firstNameField.text != inputData.firstName ||
            lastNameField.text != inputData.lastName ||
            emailField.text != inputData.email
    }
    
    private var isFilled: Bool {
        return textFields.reduce(true) { $0 && !($1.text?.isEmpty ?? false) }
    }

    @IBAction private func pickerButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction private func textFieldEditingChanged(_ textField: TextField) {
        switch textField {
        case firstNameField:
            firstNameField.validationError = nil
        case lastNameField:
            lastNameField.validationError = nil
        case emailField:
            emailField.validationError = nil
        default:
            break
        }
        refreshButton()
    }
    
    @objc
    private func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)

            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            let photoURL = URL.init(fileURLWithPath: localPath!)
            print(photoURL)

        }
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImageView.contentMode = .scaleAspectFit
            avatarImageView.image = pickedImage
        }
     
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension UserProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            emailField.becomeFirstResponder()
        case emailField:
            firstNameField.becomeFirstResponder()
        default:
            break
        }
        return false
    }
}
