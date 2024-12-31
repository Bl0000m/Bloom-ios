import Foundation

struct VerifyProfileLocal {
    let profileCategoryImage: String
    let profileCategoryTitle: String
    let profileExpandImage: String
}

struct UserData: Decodable {
    let id: Int
    let name: String
    let phoneNumber: String
    let email: String
}


struct RefreshAccessTokenRequestBody: Codable {
    let refreshToken: String
}

struct SignInTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
