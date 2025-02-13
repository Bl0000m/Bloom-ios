import Foundation

protocol AddressServiceProtocol: AnyObject {
    func getAddress(id: Int, accessToken: String, completion: @escaping (Result<[AnotherAddressModel], Error>) -> Void)
    func createNewAddress(to endpoint: String, accessToken: String, parameters: Data, completion: @escaping (Result<Data, Error>) -> Void)
}

final class AddressService: AddressServiceProtocol {
  
    private let baseURL = "http://api.bloooom.kz:8443/v1"
    static let shared = AddressService()
    private init() {}
    
    func getAddress(id: Int, accessToken: String, completion: @escaping (Result<[AnotherAddressModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/my-address") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP ошибка \(statusCode)"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Данные не получены"])))
                return
            }
            
            do {
                let orderDetailsArray = try JSONDecoder().decode([AnotherAddressModel].self, from: data)
                completion(.success(orderDetailsArray))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func sendAddress(address: AddressModel, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/address/order") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(address)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                completion(.success(data))
            }
        }

        task.resume()
    }

    
    func createNewAddress(to endpoint: String, accessToken: String, parameters: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
       
        request.httpBody = parameters
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
