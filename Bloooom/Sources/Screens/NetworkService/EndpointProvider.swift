import Foundation

protocol EndpointProvider {
    var path: String { get }
    var method: HTTPMethod { get }
    var host: String { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

extension EndpointProvider {
    var scheme: String { "http" }
    var host: String { "api.bloooom.kz:8443" }
    var body: [String: String]? { nil }
}

extension EndpointProvider {
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/\(path)"
        
        guard let url = urlComponents.url else {
            throw ServerError.invalidRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        if let body = body, method == .post || method == .put {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw error
            }
        }
        
        return urlRequest
    }
}
