//
//  KeyboardHelper.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 02.12.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

typealias KeyboardEventClosure = (KeyboardHelperEvent, _ keyboardHeight: CGFloat) -> Void

enum KeyboardHelperEvent {
    case willShow
    case willHide
}

final class KeyboardHelper {

    // MARK: - Variables
    
    var eventClosure: KeyboardEventClosure?
    
    // MARK: - Lifecycle
    
    init() {
        addObservers()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Notification actions
    
    @objc
    private func keyBoardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            eventClosure?(.willShow, keyboardHeight)
        }
    }


    @objc
    private func keyBoardWillHide(notification: NSNotification) {
        eventClosure?(.willHide, .zero)
     }

}
