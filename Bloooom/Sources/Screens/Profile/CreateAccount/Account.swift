import Foundation

struct Account: Codable {
    let name: String
    var email: String
    var phoneNumber: String
    var password: String
    var confirmPassword: String
}
