//
//  UserListCellVM.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

struct UserListCellVM {
    
    // MARK: - Private variables
    
    private let data: User
    
    // MARK: - Initialize
    
    init(data: User) {
        self.data = data
    }
    
    // MARK: - Public

    var id: Int {
        return data.id
    }
    
    var fullName: String {
        return data.firstName + " " + data.lastName
    }
    
    var firstName: String {
        return data.firstName
    }
    
    var lastName: String {
        return data.lastName
    }

    var email: String {
        return data.email
    }

    var avatarUrl: URL? {
        if let stringUrl = data.avatarUrl, let url = URL(string: stringUrl) {
            return url
        }
        return nil
    }
    
    var createdAt: String {
        return data.createdAt
    }
}
