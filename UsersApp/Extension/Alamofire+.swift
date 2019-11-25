//
//  Alamofire+.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

extension Alamofire.Result {
    public func flatMap2<T>(_ transform: (Value) throws -> Result<T>) -> Result<T> {
        switch self {
        case .success(let value):
            do {
                return try transform(value)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
