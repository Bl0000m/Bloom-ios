import Foundation

enum UserEndpoint: EndpointProvider {
    
    case forgotPassword(email: String, password: String, confitmPassword: String)
    case login(username: String, password: String)
    case register(name: String, email: String, phoneNumber: String, password: String, confirmPassword: String)
    case confirmCode(email: String, resetCode: String)
    case resetCode(email: String)
    
    var path: String {
        switch self {
        case .forgotPassword:
            return "/client/users/forgot-password"
        case .login:
            return "/users/login"
        case .register:
            return "/client/users"
        case .confirmCode:
            return "/client/users/reset-code/validate"
        case .resetCode:
            return "/client/users/reset-code"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .forgotPassword: .put
        case .login, .register, .confirmCode, .resetCode: .post
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .forgotPassword, .login, .register, .confirmCode, .resetCode:
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .login(let username, let password):
            return ["username": username, "password": password]
        case .register(let name, let email, let phoneNumber, let password, let confirmPassword):
            return ["name": name, "email": email, "phoneNumber": phoneNumber, "password": password, "confrimPassword": confirmPassword]
        case .confirmCode(let email, let resetCode):
            return ["email": email, "resetCode": resetCode]
        case .resetCode(let email):
            return ["email": email]
        case .forgotPassword(let email, let password, let confirmPassword):
            return ["email": email, "password": password, "confirmPassword": confirmPassword]
        }
    }
}

