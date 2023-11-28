//
//  RequestService.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

struct ApiService {
    
    private let api: APIClientProtocol = APIClient()
    
    func getUsers(_ completion: @escaping (Result<User>) -> Void) {
        api.request(UsersResource(), completion: completion)
    }
    
    func create(user: NewUser, _ completion: @escaping (Result<User>) -> Void) {
        api.request(NewUserResource(with: user), completion: completion)
    }
    
    func edit(user: NewUser, id: Int, _ completion: @escaping (Result<User>) -> Void) {
        api.request(NewUserResource(with: user, id: id), completion: completion)
    }
}
