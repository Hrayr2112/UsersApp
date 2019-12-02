//
//  Resource.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 30.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

open class Resource<T> {
    let request: APIAction
    let parse: (Any) -> Result<T>
    
    init(request: APIAction, parse: @escaping (Any) -> Result<T>) {
        self.request = request
        self.parse = parse
    }
}

class UsersResource: Resource<[User]> {
    
    init() {
        super.init(request: UserAction.getUsers) { response -> Result<[User]> in
            if let data = response as? Data {
                do {
                    let decodedUsers = try JSONDecoder().decode(Array<User>.self, from: data)
                    return Result.success(decodedUsers)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
        
    }
}

class NewUserResource: Resource<User> {
    
    init(with user: NewUser) {
        super.init(request: UserAction.create(user: user)) { response -> Result<User> in
            if let data = response as? Data {
                do {
                    let decodedUser = try JSONDecoder().decode(User.self, from: data)
                    return Result.success(decodedUser)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
        
    }
    
    init(with user: NewUser, id: Int) {
        super.init(request: UserAction.edit(user: user, id: id)) { response -> Result<User> in
            if let data = response as? Data {
                do {
                    let decodedUser = try JSONDecoder().decode(User.self, from: data)
                    return Result.success(decodedUser)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
        
    }
}
