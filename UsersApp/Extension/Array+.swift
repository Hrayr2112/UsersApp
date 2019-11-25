//
//  Array+.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return (0 ..< count).contains(index) ? self[index] : nil
    }
}
