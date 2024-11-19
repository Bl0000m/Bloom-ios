import Foundation

struct CreateUserModel: Codable {
    let name: String
    let email: String
    let phoneNumber: String
    let password: String
    let confirmPassword: String
}
