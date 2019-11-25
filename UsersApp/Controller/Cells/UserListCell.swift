//
//  UserListCell.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Reusable
import UIKit

class UserListCell: UITableViewCell, NibReusable {
    
    // MARK: - UI components
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var fullNameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    // MARK: - ViewModel

    var viewModel: UserListCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            configure(with: viewModel)
        }
    }

    // MARK: - Configurations

    func configure(with viewModel: UserListCellVM) {
        fullNameLabel.text = viewModel.fullName
        emailLabel.text = viewModel.email
        avatarImageView.isHidden = viewModel.avatarUrl == nil
        avatarImageView.setImage(with: viewModel.avatarUrl)
    }
    
}
