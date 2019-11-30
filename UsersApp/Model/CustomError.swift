//
//  CustomError.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 30.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Foundation

struct CustomError: LocalizedError {
    let value: String
    var localizedDescription: String {
        return value
    }
}
