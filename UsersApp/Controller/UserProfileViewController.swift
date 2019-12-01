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
    
    // MARK: - Components
    
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Variables
    
    var inputData: NewUser?
    weak var delegate: UserProfileDelegate?
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fillFieldsIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        imagePicker.delegate = self
    }
    
    // MARK: - Configurations
    
    private func fillFieldsIfNeeded() {
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

            model.create(user: user) { user in
                self.roteToListAfterSuccess()
            }
        }
    }
    
    private func roteToListAfterSuccess() {
        self.delegate?.reloadUsersData()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction
    private func pickerButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
    }
    
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
