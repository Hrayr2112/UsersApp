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
    
    init(request: APIAction) {
        self.request = request
    }
}

class UsersResource: Resource<User> {
    
    init() {
        super.init(request: UserAction.getUsers)
    }
}

class NewUserResource: Resource<User> {
    
    init(with user: NewUser) {
        super.init(request: UserAction.create(user: user))
    }
    
    init(with user: NewUser, id: Int) {
        super.init(request: UserAction.edit(user: user, id: id))
    }
}
