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
}

extension UserAction: APIAction {
  var method: HTTPMethod {
    switch self {
    case .getUsers:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getUsers:
      return "/users"
    }
  }
  
  var actionParameters: [String : Any] {
    return [:]
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
