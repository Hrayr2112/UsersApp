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
    
    var fullName: String {
        if let data = data.results.first {
            return data.name.first + " " + data.name.last
        }
        return ""
    }
    
    var firstName: String {
        if let data = data.results.first {
            return data.name.first
        }
        return ""
    }
    
    var lastName: String {
        if let data = data.results.first {
            return data.name.last
        }
        return ""
    }

    var email: String {
        if let data = data.results.first {
            return data.email
        }
        return ""
    }

    var avatarUrl: URL? {
        if let stringUrl = data.results.first?.picture.large, let url = URL(string: stringUrl) {
            return url
        }
        return nil
    }
}
