// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Alert {
    internal enum Action {
      /// Ok
      internal static let ok = L10n.tr("Localizable", "alert.action.ok", fallback: "Ok")
    }
  }
  internal enum NavigationBar {
    /// Localizable.strings
    ///   UsersApp
    /// 
    ///   Created by Hrayr Yeghiazaryan on 02.12.2019.
    ///   Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
    internal static let back = L10n.tr("Localizable", "navigation-bar.back", fallback: "Back")
  }
  internal enum Profile {
    internal enum AvatarButton {
      /// Change
      internal static let change = L10n.tr("Localizable", "profile.avatar-button.change", fallback: "Change")
      /// Choose
      internal static let choose = L10n.tr("Localizable", "profile.avatar-button.choose", fallback: "Choose")
    }
    internal enum ConfirmButton {
      /// Change
      internal static let change = L10n.tr("Localizable", "profile.confirm-button.change", fallback: "Change")
      /// Create
      internal static let create = L10n.tr("Localizable", "profile.confirm-button.create", fallback: "Create")
    }
  }
  internal enum Request {
    /// Sorry, some problems with server
    internal static let error = L10n.tr("Localizable", "request.error", fallback: "Sorry, some problems with server")
  }
  internal enum TextField {
    internal enum Holder {
      /// Email*
      internal static let emil = L10n.tr("Localizable", "text-field.holder.emil", fallback: "Email*")
      /// First Name*
      internal static let firstName = L10n.tr("Localizable", "text-field.holder.first-name", fallback: "First Name*")
      /// Last Name*
      internal static let lastName = L10n.tr("Localizable", "text-field.holder.last-name", fallback: "Last Name*")
    }
  }
  internal enum UsersList {
    /// Users
    internal static let title = L10n.tr("Localizable", "users-list.title", fallback: "Users")
  }
  internal enum Validation {
    /// Incorrect email
    internal static let incorrectEmail = L10n.tr("Localizable", "validation.incorrect-email", fallback: "Incorrect email")
    internal enum Empty {
      /// First name must have at least one character
      internal static let firstName = L10n.tr("Localizable", "validation.empty.first-name", fallback: "First name must have at least one character")
      /// Last name must have at least one character
      internal static let lastName = L10n.tr("Localizable", "validation.empty.last-name", fallback: "Last name must have at least one character")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
