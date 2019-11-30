//
//  UserAction.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

enum UserAction {
    case getUsers
    case create(user: NewUser)
}

extension UserAction: APIAction {
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .create:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getUsers, .create:
            return "/users"
        }
    }
    
    var bodyParameters: [String : Any] {
        switch self {
        case .getUsers:
            return [:]
        case let .create(user):
            return ["first_name": user.firstName,
                    "last_name": user.lastName,
                    "email": user.email,
                    "avatar_url": user.avatarUrl ?? ""]
        }
    }
    
    var baseURL: String {
        return "https://frogogo-test.herokuapp.com"
    }
    
    var authHeader: [String : String] {
        return ["Content-Type": "application/json", "Accept" : "application/json"]
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
