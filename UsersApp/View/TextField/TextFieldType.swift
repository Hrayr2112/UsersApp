//
//  TextFieldType.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

enum TextFieldType: String {
    case email
    case password
    case text

    var isSecureTextEntry: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }

    var clearButtonMode: UITextField.ViewMode {
        switch self {
        case .password:
            return .whileEditing
        default:
            return .never
        }
    }

    var textSpace: Int {
        switch self {
        case .password:
            return 5
        default:
            return 0
        }
    }

    var textFont: UIFont {
        switch self {
        case .password:
            return UIFont.systemFont(ofSize: 20)
        default:
            return UIFont.systemFont(ofSize: 20)
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }
}
