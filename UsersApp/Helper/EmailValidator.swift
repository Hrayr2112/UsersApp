//
//  EmailValidator.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

class EmailValidator: ValueValidator {
    
    func validate(text: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,50}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        if emailTest.evaluate(with: text) {
            return nil
        } else {
            return L10n.Validation.incorrectEmail
        }
    }
    
}
