//
//  TextFieldStyle.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

enum TextFieldStyle: String {
    case `default`
    case underLined

    var font: UIFont {
        switch self {
        case .default:
            return UIFont.systemFont(ofSize: 20)
        default:
            return UIFont.systemFont(ofSize: 15)
        }
    }
}
