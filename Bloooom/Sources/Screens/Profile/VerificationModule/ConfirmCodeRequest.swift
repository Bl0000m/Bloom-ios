import Foundation

struct ConfirmCodeRequest: Codable {
    let email: String
    let resetCode: String
}
