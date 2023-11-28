//
//  UsersListViewController.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire
import UIKit

class UsersListViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let profileSegue = "UserProfile"
        static let rowHeight: CGFloat = 80
    }
    
    // MARK: - UI components
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingView: LoadingView!
    
    // MARK: - Variables
    
    private var viewModels: [UserListCellVM] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // Set this variable in order to pass userInfo to Profile page
    private var profileInputData: NewUser?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserProfileViewController {
            destination.delegate = self
            destination.inputData = profileInputData
        }
    }
    
    // MARK: - Configurations
    
    private func configureNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: Asset.Colors.white.color]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = L10n.UsersList.title
    }
    
    private func configureTableView() {
        tableView.register(cellType: UserListCell.self)
    }
    
    // MARK: - Actions
    
    @IBAction private func createUserButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "\(UserProfileViewController.self)") as? UserProfileViewController {
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction.init(title: L10n.Alert.Action.ok, style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModels[safe: indexPath.row] else {
            return
        }
        profileInputData = NewUser(id: 0,
                                   firstName: viewModel.firstName,
                                   lastName: viewModel.lastName,
                                   email: viewModel.email,
                                   avatarUrl: viewModel.avatarUrl?.absoluteString ?? "")
        performSegue(withIdentifier: Constants.profileSegue, sender: self)
    }
}

// MARK: - UITableViewDataSource

extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as UserListCell
        cell.viewModel = viewModels[safe: indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
}

// MARK: - API

extension UsersListViewController {
    func loadData() {
        loadingView.startLoading()
        Task {
            do {
                let users = try await ApiService().getUsers()
                viewModels = [UserListCellVM(data: users)]
            } catch {
                self.showError(message: L10n.Request.error)
            }
        }
    }
}

// MARK: - UserProfileDelegate

extension UsersListViewController: UserProfileDelegate {
    
    func reloadUsersData() {
        loadData()
    }
    
}
