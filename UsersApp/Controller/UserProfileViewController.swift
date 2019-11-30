//
//  UserProfileViewController.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

protocol UserProfileDelegate {
    
}

class UserProfileViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var firstNameField: TextField!
    @IBOutlet private var lastNameField: TextField!
    @IBOutlet private var emailField: TextField!
    
    // MARK: - Variables
    
    var inputData: NewUser?
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
        //emailField.validationError = EmailValidator().validate(text: emailTextField.text ?? "")?.text
        let model = ApiService()
        let user = NewUser(firstName: firstName, lastName: lastName, email: email, avatarUrl: nil)
        model.create(user: user) { user in
            
        }
    }
    
}
