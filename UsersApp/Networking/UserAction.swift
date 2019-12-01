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
    case edit(user: NewUser, id: Int)
}

extension UserAction: APIAction {
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .create:
            return .post
        case .edit:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .getUsers, .create:
            return "/users"
        case let .edit(_, id):
            return "/user/\(id)"
        }
    }
    
    var bodyParameters: [String : Any] {
        switch self {
        case .getUsers:
            return [:]
        case let .create(user), let .edit(user, _):
            return ["first_name": user.firstName,
                    "last_name": user.lastName,
                    "email": user.email,
                    "url": user.avatarUrl ?? ""]
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
