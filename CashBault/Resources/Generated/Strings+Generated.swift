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
  /// CashBault
  internal static let appName = L10n.tr("Localizable", "app_name", fallback: "CashBault")
  /// Cancelled
  internal static let cancelled = L10n.tr("Localizable", "cancelled", fallback: "Cancelled")
  /// Email
  internal static let emailPlaceholder = L10n.tr("Localizable", "email_placeholder", fallback: "Email")
  /// An error has occurred. Please try again in a while
  internal static let errorBadRequestMessage = L10n.tr("Localizable", "error_bad_request_message", fallback: "An error has occurred. Please try again in a while")
  /// Incorrect email format
  internal static let errorEmail = L10n.tr("Localizable", "error_email", fallback: "Incorrect email format")
  /// The field cannot be empty
  internal static let errorEmpty = L10n.tr("Localizable", "error_empty", fallback: "The field cannot be empty")
  /// The password must contain at least 8 characters and a number
  internal static let errorPassword = L10n.tr("Localizable", "error_password", fallback: "The password must contain at least 8 characters and a number")
  /// Could not establish connection to the server. Please try again in a while
  internal static let errorServerErrorMessage = L10n.tr("Localizable", "error_server_error_message", fallback: "Could not establish connection to the server. Please try again in a while")
  /// Looks like the server is taking to long to respond. Please try again in a while
  internal static let errorTimeOutMessage = L10n.tr("Localizable", "error_time_out_message", fallback: "Looks like the server is taking to long to respond. Please try again in a while")
  /// Add account
  internal static let financeAddAccountLabel = L10n.tr("Localizable", "finance_add_account_label", fallback: "Add account")
  /// Add new account
  internal static let financeAddAccountTitle = L10n.tr("Localizable", "finance_add_account_title", fallback: "Add new account")
  /// You don't have an account yet
  internal static let financeNoAccountLabel = L10n.tr("Localizable", "finance_no_account_label", fallback: "You don't have an account yet")
  /// Normal accounts
  internal static let financeNormalAccountsTitle = L10n.tr("Localizable", "finance_normal_accounts_title", fallback: "Normal accounts")
  /// Saving accounts
  internal static let financeSavingAccountsTitle = L10n.tr("Localizable", "finance_saving_accounts_title", fallback: "Saving accounts")
  /// Total balance
  internal static let financeTotalBalanceLabel = L10n.tr("Localizable", "finance_total_balance_label", fallback: "Total balance")
  /// No balance available
  internal static let financeTotalBalanceNoBalanceLabel = L10n.tr("Localizable", "finance_total_balance_no_balance_label", fallback: "No balance available")
  /// Add money
  internal static let homeActionAddMoney = L10n.tr("Localizable", "home_action_add_money", fallback: "Add money")
  /// Insights
  internal static let homeActionInsights = L10n.tr("Localizable", "home_action_insights", fallback: "Insights")
  /// Scheduled
  internal static let homeActionScheduled = L10n.tr("Localizable", "home_action_scheduled", fallback: "Scheduled")
  /// Send money
  internal static let homeActionSendMoney = L10n.tr("Localizable", "home_action_send_money", fallback: "Send money")
  /// Login
  internal static let login = L10n.tr("Localizable", "login", fallback: "Login")
  /// Fields cannot be empty
  internal static let loginEmptyFieldsError = L10n.tr("Localizable", "login_empty_fields_error", fallback: "Fields cannot be empty")
  /// An error occurred while trying to log in
  internal static let loginError = L10n.tr("Localizable", "login_error", fallback: "An error occurred while trying to log in")
  /// The email or password entered does not exist or does not match
  internal static let loginNotFoundError = L10n.tr("Localizable", "login_not_found_error", fallback: "The email or password entered does not exist or does not match")
  /// Fields must be valid to continue
  internal static let loginValidFieldsError = L10n.tr("Localizable", "login_valid_fields_error", fallback: "Fields must be valid to continue")
  /// You have no movements
  internal static let noMovements = L10n.tr("Localizable", "no_movements", fallback: "You have no movements")
  /// Password
  internal static let passwordPlaceholder = L10n.tr("Localizable", "password_placeholder", fallback: "Password")
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
  /// Use biometric recognition
  internal static let useBiometricLabel = L10n.tr("Localizable", "use_biometric_label", fallback: "Use biometric recognition")
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
