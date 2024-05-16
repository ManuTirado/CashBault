// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Accept
  internal static let accept = L10n.tr("Localizable", "accept")
  /// From %@
  internal static func accountMovementSenderFrom(_ p1: Any) -> String {
    return L10n.tr("Localizable", "account_movement_sender_from", String(describing: p1))
  }
  /// To %@
  internal static func accountMovementSenderTo(_ p1: Any) -> String {
    return L10n.tr("Localizable", "account_movement_sender_to", String(describing: p1))
  }
  /// Normal account
  internal static let accountTypeNormalTitle = L10n.tr("Localizable", "account_type_normal_title")
  /// Saving account
  internal static let accountTypeSavingTitle = L10n.tr("Localizable", "account_type_saving_title")
  /// Address
  internal static let addressPlaceholder = L10n.tr("Localizable", "address_placeholder")
  /// CashBault
  internal static let appName = L10n.tr("Localizable", "app_name")
  /// Birth Date
  internal static let birthDatePlaceholder = L10n.tr("Localizable", "birth_date_placeholder")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Cancelled
  internal static let cancelled = L10n.tr("Localizable", "cancelled")
  /// Email
  internal static let emailPlaceholder = L10n.tr("Localizable", "email_placeholder")
  /// An error has occurred. Please try again in a while
  internal static let errorBadRequestMessage = L10n.tr("Localizable", "error_bad_request_message")
  /// Incorrect email format
  internal static let errorEmail = L10n.tr("Localizable", "error_email")
  /// The field cannot be empty
  internal static let errorEmpty = L10n.tr("Localizable", "error_empty")
  /// The password must contain at least 8 characters and a number
  internal static let errorPassword = L10n.tr("Localizable", "error_password")
  /// Could not establish connection to the server. Please try again in a while
  internal static let errorServerErrorMessage = L10n.tr("Localizable", "error_server_error_message")
  /// Looks like the server is taking to long to respond. Please try again in a while
  internal static let errorTimeOutMessage = L10n.tr("Localizable", "error_time_out_message")
  /// Add account
  internal static let financeAddAccountLabel = L10n.tr("Localizable", "finance_add_account_label")
  /// Add new account
  internal static let financeAddAccountTitle = L10n.tr("Localizable", "finance_add_account_title")
  /// You don't have an account yet
  internal static let financeNoAccountLabel = L10n.tr("Localizable", "finance_no_account_label")
  /// Normal accounts
  internal static let financeNormalAccountsTitle = L10n.tr("Localizable", "finance_normal_accounts_title")
  /// Saving accounts
  internal static let financeSavingAccountsTitle = L10n.tr("Localizable", "finance_saving_accounts_title")
  /// Total balance
  internal static let financeTotalBalanceLabel = L10n.tr("Localizable", "finance_total_balance_label")
  /// No balance available
  internal static let financeTotalBalanceNoBalanceLabel = L10n.tr("Localizable", "finance_total_balance_no_balance_label")
  /// Full name
  internal static let fullNamePlaceholder = L10n.tr("Localizable", "full_name_placeholder")
  /// Add money
  internal static let homeActionAddMoney = L10n.tr("Localizable", "home_action_add_money")
  /// Insights
  internal static let homeActionInsights = L10n.tr("Localizable", "home_action_insights")
  /// Scheduled
  internal static let homeActionScheduled = L10n.tr("Localizable", "home_action_scheduled")
  /// Send money
  internal static let homeActionSendMoney = L10n.tr("Localizable", "home_action_send_money")
  /// Login
  internal static let login = L10n.tr("Localizable", "login")
  /// Fields cannot be empty
  internal static let loginEmptyFieldsError = L10n.tr("Localizable", "login_empty_fields_error")
  /// An error occurred while trying to log in
  internal static let loginError = L10n.tr("Localizable", "login_error")
  /// The email or password entered does not exist or does not match
  internal static let loginNotFoundError = L10n.tr("Localizable", "login_not_found_error")
  /// Fields must be valid to continue
  internal static let loginValidFieldsError = L10n.tr("Localizable", "login_valid_fields_error")
  /// You have no movements
  internal static let noMovements = L10n.tr("Localizable", "no_movements")
  /// Password
  internal static let passwordPlaceholder = L10n.tr("Localizable", "password_placeholder")
  /// Pending
  internal static let pending = L10n.tr("Localizable", "pending")
  /// Phone
  internal static let phonePlaceholder = L10n.tr("Localizable", "phone_placeholder")
  /// Save
  internal static let save = L10n.tr("Localizable", "save")
  /// Cards
  internal static let tabCardsTitle = L10n.tr("Localizable", "tab_cards_title")
  /// Finances
  internal static let tabFinanceTitle = L10n.tr("Localizable", "tab_finance_title")
  /// Home
  internal static let tabHomeTitle = L10n.tr("Localizable", "tab_home_title")
  /// User
  internal static let tabUserTitle = L10n.tr("Localizable", "tab_user_title")
  /// Use biometric recognition
  internal static let useBiometricLabel = L10n.tr("Localizable", "use_biometric_label")
  /// Configuration
  internal static let userConfigLabel = L10n.tr("Localizable", "user_config_label")
  /// Language
  internal static let userConfigLanguage = L10n.tr("Localizable", "user_config_language")
  /// Are you sure you want to log out?
  internal static let userLogoutConfirmationMessage = L10n.tr("Localizable", "user_logout_confirmation_message")
  /// Log out
  internal static let userLogoutConfirmationTitle = L10n.tr("Localizable", "user_logout_confirmation_title")
  /// Log out
  internal static let userLogoutLabel = L10n.tr("Localizable", "user_logout_label")
  /// Personal info
  internal static let userPersonalInfoLabel = L10n.tr("Localizable", "user_personal_info_label")
  /// It is necessary to reload the app to apply the changes
  internal static let userSaveChangesConfirmationMessage = L10n.tr("Localizable", "user_save_changes_confirmation_message")
  /// Reload
  internal static let userSaveChangesConfirmationTitle = L10n.tr("Localizable", "user_save_changes_confirmation_title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        if let pathBundle = BundleToken.bundle.path(forResource: UserDefaults.standard.string(forKey: Constants.defaultsLangKey) ?? "en", ofType: "lproj"), let bundle = Bundle(path: pathBundle) {
            let format = bundle.localizedString(forKey: key, value: nil, table: table)
            return String(format: format, arguments: args)
        }
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale(identifier: Locale.current.identifier), arguments: args)
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

