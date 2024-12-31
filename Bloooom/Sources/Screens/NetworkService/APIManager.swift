import Foundation

protocol APIManager {
    func sendRequest<T: Decodable>(to endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}

class APIManagerImpl: APIManager {
    
    private let session = URLSession(configuration: .default)
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private let baseURL = "http://api.bloooom.kz:8443/v1"
    
    static let shared = APIManagerImpl()
    private init() {}
    
    func sendRequest<T: Decodable>(to endpoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        let request = try endpoint.asURLRequest()
        let (data, response) = try await session.data(for: request)
        let _ = try httpResponse(response: response)
        let result = try decoder.decode(responseModel, from: data)
        return result
    }
    
    private func httpResponse(response: URLResponse?) throws -> HTTPURLResponse {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServerError.nonHTTPResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            return httpResponse
        case 400...499:
            throw ServerError.requestFailed(httpResponse.statusCode)
        default:
            throw ServerError.serverError(httpResponse.statusCode)
        }
    }

}
