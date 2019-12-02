// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Profile {
    internal enum AvatarButton {
      /// Change
      internal static let change = L10n.tr("Localizable", "profile.avatar-button.change")
      /// Choose
      internal static let choose = L10n.tr("Localizable", "profile.avatar-button.choose")
    }
    internal enum ConfirmButton {
      /// Change
      internal static let change = L10n.tr("Localizable", "profile.confirm-button.change")
      /// Create
      internal static let create = L10n.tr("Localizable", "profile.confirm-button.create")
    }
  }

  internal enum Request {
    /// Sorry, some problems with server
    internal static let error = L10n.tr("Localizable", "request.error")
  }

  internal enum TextField {
    internal enum Holder {
      /// Email
      internal static let emil = L10n.tr("Localizable", "text-field.holder.emil")
      /// First Name
      internal static let firstName = L10n.tr("Localizable", "text-field.holder.first-name")
      /// Last Name
      internal static let lastName = L10n.tr("Localizable", "text-field.holder.last-name")
    }
  }

  internal enum UsersList {
    /// Users
    internal static let title = L10n.tr("Localizable", "users-list.title")
  }

  internal enum Validation {
    /// Incorrect email
    internal static let incorrectEmail = L10n.tr("Localizable", "validation.incorrect-email")
    internal enum Empty {
      /// First name must have at least one character
      internal static let firstName = L10n.tr("Localizable", "validation.empty.first-name")
      /// Last name must have at least one character
      internal static let lastName = L10n.tr("Localizable", "validation.empty.last-name")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
