//
//  User.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit
import Foundation

struct User: Decodable {
    
    let results: [UserModel]
    
    struct UserModel: Decodable {
        let gender: String
        let name: Name
        let email: String
        let picture: Picture
        
        struct Name: Decodable {
            let title: String
            let first: String
            let last: String
        }
        
        struct Picture: Decodable {
            let large: String
        }
    }
}
