import Foundation

protocol MySubscribeAPIManagerProtocol {
    func createSubscription(model: CreateSubscribeModel, accessToken: String, completion: @escaping (Result<ResponseData, Error>) -> Void)
    func fetchOrderDetails(orderId: Int, accessToken: String, completion: @escaping (Result<[EditOrderDetailsModel], Error>) -> Void)
    func fetchUserOrder(orderId: Int, accessToken: String, completion: @escaping (Result<EditOrderDetailsModel, Error>) -> Void)
}

class MySubscribeAPIManager: MySubscribeAPIManagerProtocol {
    private let baseURL = "http://api.bloooom.kz:8443/v1"
    
    static let shared = MySubscribeAPIManager()
    private init() {}
    private var bearerToken: String?
    
    func setBearerToken(_ token: String) {
        bearerToken = token
    }
    
    func createSubscription(model: CreateSubscribeModel, accessToken: String, completion: @escaping (Result<ResponseData, Error>) -> Void) {
        // Убедитесь, что URL верный
        guard let url = URL(string: baseURL + "/client/subscription") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Конвертируем объект в JSON
        guard let jsonData = try? JSONEncoder().encode(model) else {
            completion(.failure(NSError(domain: "Encoding error", code: 0, userInfo: nil)))
            return
        }
        
        // Настраиваем запрос
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        // Выполняем запрос
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                        completion(.success(responseData))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                }
            } else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                completion(.failure(NSError(domain: "Unexpected status code: \(statusCode)", code: statusCode, userInfo: nil)))
            }
        }
        task.resume()
    }
 
    func fetchOrderDetails(orderId: Int, accessToken: String, completion: @escaping (Result<[EditOrderDetailsModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/client/order/subscription/\(orderId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Некорректный URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Добавляем токен доступа в заголовок Authorization
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
                let orderDetailsArray = try JSONDecoder().decode([EditOrderDetailsModel].self, from: data)
                completion(.success(orderDetailsArray))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchUserOrder(orderId: Int, accessToken: String, completion: @escaping (Result<EditOrderDetailsModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/client/order/\(orderId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Некорректный URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Добавляем токен доступа в заголовок Authorization
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
                let orderDetailsArray = try JSONDecoder().decode(EditOrderDetailsModel.self, from: data)
                completion(.success(orderDetailsArray))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
