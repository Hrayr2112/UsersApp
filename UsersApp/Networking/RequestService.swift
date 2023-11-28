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
    
    func getUsers() async throws -> User {
        let data = try await api.request(UsersResource())
        do {
            let decodedUsers = try JSONDecoder().decode(User.self, from: data)
            return decodedUsers
        } catch {
            throw CustomError(value: error.localizedDescription)
        }
    }
    
    func create(user: NewUser) async throws -> () {
        let data = try await api.request(NewUserResource(with: user))
        return
    }
    
    func edit(user: NewUser, id: Int) async throws -> () {
        let data = try await api.request(NewUserResource(with: user, id: id))
        return
    }
}
