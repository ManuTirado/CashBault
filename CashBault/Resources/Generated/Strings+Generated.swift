// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// From %@
  internal static func accountMovementSenderFrom(_ p1: Any) -> String {
    return L10n.tr("Localizable", "account_movement_sender_from", String(describing: p1), fallback: "From %@")
  }
  /// To %@
  internal static func accountMovementSenderTo(_ p1: Any) -> String {
    return L10n.tr("Localizable", "account_movement_sender_to", String(describing: p1), fallback: "To %@")
  }
  /// Normal account
  internal static let accountTypeNormalTitle = L10n.tr("Localizable", "account_type_normal_title", fallback: "Normal account")
  /// Saving account
  internal static let accountTypeSavingTitle = L10n.tr("Localizable", "account_type_saving_title", fallback: "Saving account")
  /// Cancelled
  internal static let cancelled = L10n.tr("Localizable", "cancelled", fallback: "Cancelled")
  /// Add money
  internal static let homeActionAddMoney = L10n.tr("Localizable", "home_action_add_money", fallback: "Add money")
  /// Insights
  internal static let homeActionInsights = L10n.tr("Localizable", "home_action_insights", fallback: "Insights")
  /// Scheduled
  internal static let homeActionScheduled = L10n.tr("Localizable", "home_action_scheduled", fallback: "Scheduled")
  /// Send money
  internal static let homeActionSendMoney = L10n.tr("Localizable", "home_action_send_money", fallback: "Send money")
  /// Pending
  internal static let pending = L10n.tr("Localizable", "pending", fallback: "Pending")
  /// Cards
  internal static let tabCardsTitle = L10n.tr("Localizable", "tab_cards_title", fallback: "Cards")
  /// Explore
  internal static let tabExploreTitle = L10n.tr("Localizable", "tab_explore_title", fallback: "Explore")
  /// Finances
  internal static let tabFinanceTitle = L10n.tr("Localizable", "tab_finance_title", fallback: "Finances")
  /// Home
  internal static let tabHomeTitle = L10n.tr("Localizable", "tab_home_title", fallback: "Home")
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
