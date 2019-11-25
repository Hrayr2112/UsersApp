//
//  ValueValidatorProtocol.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

protocol ValueValidator {
    func validate(text: String) -> String?
}
