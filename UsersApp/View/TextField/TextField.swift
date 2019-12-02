//
//  TextField.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import MaterialTextField
import UIKit

class TextField: MFTextField, UITextFieldDelegate {

    // MARK: - LifeCycle

    private var placeholderText: String? 

    override init(frame: CGRect) {
        type = .text
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        type = .text
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Configure

    private func setup() {
        autocorrectionType = .no
        autocapitalizationType = .none
        textColor = .white
        tintColor = .gray
        font = UIFont.systemFont(ofSize: 20)
        placeholderColor = .gray

        defaultPlaceholderColor = .gray
        placeholderFont = UIFont.systemFont(ofSize: 12)
        keyboardAppearance = .dark
    }

    var type: TextFieldType {
        didSet {
            isSecureTextEntry = type.isSecureTextEntry
            clearButtonMode = type.clearButtonMode
            keyboardType = type.keyboardType
            font = type.textFont
            defaultTextAttributes.updateValue(type.textSpace, forKey: NSAttributedString.Key.kern)
        }
    }

    func set(placeholder: String, style: TextFieldStyle = .default) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,

            .font: style.font,
        ]

        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        placeholderText = placeholder

        if style == .underLined {
            underlineColor = .gray
            underlineEditingHeight = 1
            underlineHeight = 1
        } else {
            underlineColor = .clear
            underlineEditingHeight = 0
            underlineHeight = 0
        }
    }

    var validationError: String? {
        didSet {
            if let error = validationError {
                placeholder = error
                placeholderColor = .red
                tintColor = .red
            } else {
                placeholder = placeholderText
                defaultPlaceholderColor = .gray
                placeholderColor = .gray
                textColor = .white
                tintColor = .gray
            }
        }
    }

    // MARK: - Layout

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 71)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return super.clearButtonRect(forBounds: bounds).insetBy(dx: -8, dy: -8).offsetBy(dx: 8, dy: 0)
    }
}
