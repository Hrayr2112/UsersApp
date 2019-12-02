//
//  NewUser.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 30.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

struct NewUser {
    let id: Int?
    let firstName: String
    let lastName: String
    let email: String
    let avatarUrl: String?
    
    init(id: Int? = nil, firstName: String, lastName: String, email: String, avatarUrl: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.avatarUrl = avatarUrl
    }
 }
