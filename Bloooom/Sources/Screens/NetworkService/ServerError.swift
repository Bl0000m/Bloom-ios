import Foundation

enum ServerError: Error, CustomStringConvertible {
    case nonHTTPResponse
    case requestFailed(Int)
    case serverError(Int)
    case invalidRequest
    case invalidData
    
    var description: String {
        switch self {
        case .nonHTTPResponse:
            "Non-HTTP response received"
        case .requestFailed(let status):
            "Received HTTP \(status)"
        case .serverError(let status):
            "Server Error - \(status)"
        case .invalidRequest:
            "Failed to create request"
        case .invalidData:
            "Requested file has invalid data"
        }
    }
}
