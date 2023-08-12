// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Gallery {
    internal enum NoVideos {
      /// There are no videos, please try with another date.
      internal static let label = L10n.tr("Localizable", "gallery.noVideos.label", fallback: "There are no videos, please try with another date.")
    }
    internal enum Picker {
      /// Videos before:
      internal static let label = L10n.tr("Localizable", "gallery.picker.label", fallback: "Videos before:")
    }
  }
  internal enum Intro {
    /// In this app you will be able to see and interact with the awesome videos that you have on the gallery. Note: The app requires permission to see the gallery
    internal static let body = L10n.tr("Localizable", "intro.body", fallback: "In this app you will be able to see and interact with the awesome videos that you have on the gallery. Note: The app requires permission to see the gallery")
    /// Welcome to CameraTok!
    internal static let title = L10n.tr("Localizable", "intro.title", fallback: "Welcome to CameraTok!")
    internal enum Button {
      /// Get Started!
      internal static let title = L10n.tr("Localizable", "intro.button.title", fallback: "Get Started!")
    }
    internal enum PermissionDenied {
      /// Permission to access gallery was denied
      internal static let label = L10n.tr("Localizable", "intro.permissionDenied.label", fallback: "Permission to access gallery was denied")
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
