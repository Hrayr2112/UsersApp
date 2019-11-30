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
        static let cellName = "UserListCell"
        static let rowHeight: CGFloat = 60
        static let profileSegue = "UserProfile"
    }
    
    // MARK: - UI components
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Variables
    
    private var viewModels: [UserListCellVM] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
            destination.inputData = profileInputData
        }
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.register(cellType: UserListCell.self)
    }
    
    // MARK: - Actions
    
    @IBAction private func createUserButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - UITableViewDelegate

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModels[safe: indexPath.row] else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        profileInputData = NewUser(firstName: viewModel.firstName,
                                   lastName: viewModel.lastName,
                                   email: viewModel.email,
                                   avatarUrl: nil)
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
        let model = ApiService()
        model.getUsers { result in
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
