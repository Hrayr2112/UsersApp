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
    @IBOutlet private var chooseAvatarButton: UIButton!
    @IBOutlet private var loadinView: LoadingView!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Components
    
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Helpers
    
    private let keyboardHelper = KeyboardHelper()
    
    // MARK: - Public variables
    
    var inputData: NewUser?
    weak var delegate: UserProfileDelegate?
    
    // MARK: - Private variables
    
    private var textFields: [TextField] {
        return [firstNameField, lastNameField, emailField]
    }
    
    private var selectedImageURL: String?
    private let requestService = ApiService()
    
    // MARK: - Validation
    
    private var isValid: Bool {
        return emailField.validationError == nil && firstNameField.validationError == nil && lastNameField.validationError == nil
    }
    
    // Use for edit mode
    private var hasChanges: Bool {
        guard let inputData = inputData else {
            return true
        }
        
        return firstNameField.text != inputData.firstName ||
            lastNameField.text != inputData.lastName ||
            emailField.text != inputData.email
    }
    
    private var isFilled: Bool {
        return textFields.reduce(true) { $0 && !($1.text?.isEmpty ?? false) }
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureViews()
        fillInfoNeeded()
        refreshConfirmButton()
        configureKeyboard()
        
        // Set picker delegate
        imagePicker.delegate = self
        
        // Tap to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Configurations
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = L10n.NavigationBar.back
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func configureViews() {
        firstNameField.set(placeholder: L10n.TextField.Holder.firstName, style: .underLined)
        lastNameField.set(placeholder: L10n.TextField.Holder.lastName, style: .underLined)
        emailField.set(placeholder: L10n.TextField.Holder.emil, style: .underLined)
    }
    
    private func fillInfoNeeded() {
        if let inputData = inputData {
            firstNameField.text = inputData.firstName
            lastNameField.text = inputData.lastName
            emailField.text = inputData.email
            confirmButton.setTitle(L10n.Profile.ConfirmButton.change, for: .normal)
        } else {
            confirmButton.setTitle(L10n.Profile.ConfirmButton.create, for: .normal)
        }
        configureAvatar(with: inputData?.avatarUrl)
    }
    
    private func configureKeyboard() {
        keyboardHelper.eventClosure = { event, height in
            switch event {
            case .willShow:
                self.bottomConstraint.constant = height - self.view.safeAreaInsets.bottom
            case .willHide:
                self.bottomConstraint.constant = height
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureAvatar(with urlString: String?) {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        if let urlString = urlString, let avatarUrl = URL(string: urlString) {
            avatarImageView.setImage(with: avatarUrl)
            chooseAvatarButton.setTitle(L10n.Profile.AvatarButton.change, for: .normal)
        } else {
            chooseAvatarButton.setTitle(L10n.Profile.AvatarButton.choose, for: .normal)
        }
    }
    
    private func refreshConfirmButton() {
        confirmButton.isEnabled = hasChanges && isFilled
        confirmButton.backgroundColor = confirmButton.isEnabled ? Asset.Colors.neon.color : Asset.Colors.slateGrey.color
        confirmButton.setTitleColor(confirmButton.isEnabled ? Asset.Colors.white.color : Asset.Colors.slateGreyTwo.color,
                                    for: .normal)
    }
    
    // MARK: - Routing
    
    private func roteToListAfterSuccess() {
        self.delegate?.reloadUsersData()
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Actions

extension UserProfileViewController {
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let firstName = firstNameField.text,
            let lastName = lastNameField.text,
            let email = emailField.text else { return }
        
        let user = NewUser(firstName: firstName, lastName: lastName, email: email, avatarUrl: selectedImageURL ?? "")
        
        if let id = inputData?.id {
            edit(user: user, id: id)
        } else {
            if let incorrectEmail = EmailValidator().validate(text: email) {
                emailField.validationError = incorrectEmail
            }

            if firstName.isEmpty {
                firstNameField.validationError = L10n.Validation.Empty.firstName
            }

            if lastName.isEmpty {
                lastNameField.validationError = L10n.Validation.Empty.lastName
            }

            if isValid {
                create(user: user)
            }
        }
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
        refreshConfirmButton()
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - API

extension UserProfileViewController {
    
    private func create(user: NewUser) {
        loadinView.startLoading()
        dismissKeyboard()
        requestService.create(user: user) { result in
            self.loadinView.stopLoading()
            switch result {
            case .success:
                self.roteToListAfterSuccess()
            case.failure:
                self.showError(message: L10n.Request.error)
            }
        }
    }
    
    private func edit(user: NewUser, id: Int) {
        loadinView.startLoading()
        dismissKeyboard()
        requestService.edit(user: user, id: id) { result in
            self.loadinView.stopLoading()
            switch result {
            case .success:
                self.roteToListAfterSuccess()
            case .failure:
                self.showError(message: L10n.Request.error)
            }
        }
    }
    
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImageView.contentMode = .scaleAspectFit
            avatarImageView.image = pickedImage
            chooseAvatarButton.setTitle(L10n.Profile.AvatarButton.change, for: .normal)
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
