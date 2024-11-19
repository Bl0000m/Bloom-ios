import Foundation

struct ConfirmPasswordModel: Codable {
    let email: String
    let newPassword: String
    let confirmNewPassword: String
}
