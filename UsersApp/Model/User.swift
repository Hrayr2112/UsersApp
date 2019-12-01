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
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let avatarUrl: String?
    let createdAt: String
    let updatedAt: String
    let url: String?
    
    enum CodingKeys: String, CodingKey {
      case id, email, url
      case firstName = "first_name"
      case lastName = "last_name"
      case createdAt = "created_at"
      case avatarUrl = "avatar_url"
      case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        avatarUrl = try? values.decode(String.self, forKey: .avatarUrl)
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
        url = try values.decode(String.self, forKey: .url)
    }
}
