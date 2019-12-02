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
        static let cellName = "UserListCell"
        static let rowHeight: CGFloat = 80
    }
    
    // MARK: - UI components
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
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
        configureTableView()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserProfileViewController {
            destination.delegate = self
            destination.inputData = profileInputData
        }
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.register(cellType: UserListCell.self)
    }
    
    private func showIndicator() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    private func hideIndicator() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    // MARK: - Actions
    
    @IBAction private func createUserButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "\(UserProfileViewController.self)") as? UserProfileViewController {
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

// MARK: - UITableViewDelegate

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModels[safe: indexPath.row] else {
            return
        }
        profileInputData = NewUser(firstName: viewModel.firstName,
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
        showIndicator()
        let model = ApiService()
        model.getUsers { result in
            self.hideIndicator()
            switch result {
            case let .success(data):
                self.viewModels = data.map { UserListCellVM(data: $0) }
                break
            case let .failure(error):
                print(error.localizedDescription)
                break
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
