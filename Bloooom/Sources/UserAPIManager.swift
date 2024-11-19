import Foundation

protocol UserAPIManagerProtocol {
    func postRequest(to endpoint: String, parameters: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void)
    func signUpData(to endpoint: String, parameters: Data, completion: @escaping (Result<Data, Error>) -> Void)
    func loadCountries(completion: @escaping (Result<[Country], Error>) -> Void)
    func confirmCode(email: String, code: String, completion: @escaping (Result<String, Error>) -> Void)
    func resetCode(email: String, completion: @escaping (Result<String, Error>) -> Void)
    func forgotPassword(email: String, newPassword: String, confirmNewPassword: String, completion: @escaping (Result<String, Error>) -> Void)
}

class UserAPIManager:  UserAPIManagerProtocol {
    
    private let baseURL = "http://api.bloooom.kz:8443/v1"
    
    static let shared = UserAPIManager()
    private init() {}
    private var bearerToken: String?
    
    func setBearerToken(_ token: String) {
        bearerToken = token
    }
    
    func postRequest(to endpoint: String, parameters: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = bearerToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(json))
                }
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }
        
        task.resume()
    }
    
    func signUpData(to endpoint: String, parameters: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = bearerToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = parameters // Параметры уже в формате Data
        
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
    
    func loadCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "PhoneExtensions", withExtension: "json") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 404, userInfo: nil)))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode([Country].self, from: data)
            completion(.success(countries))
        } catch {
            completion(.failure(error))
        }
    }
    
    func confirmCode(email: String, code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/client/users/reset-code/validate") else {
            completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Некорректный URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let confirmRequest = ConfirmCodeRequest(email: email, resetCode: code)
        
        do {
            request.httpBody = try JSONEncoder().encode(confirmRequest)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let errorMessage = "Ошибка сервера с кодом: \(statusCode)"
                completion(.failure(NSError(domain: "AuthService", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            guard let data = data, let message = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных в ответе"])))
                return
            }
            
            completion(.success(message))
        }.resume()
    }
    
    func resetCode(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/client/users/reset-code") else {
            completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Некорректный URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let resetCodeRequest = ResetCodeRequest(email: email)
        
        do {
            request.httpBody = try JSONEncoder().encode(resetCodeRequest)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let errorMessage = "Ошибка сервера с кодом: \(statusCode)"
                completion(.failure(NSError(domain: "AuthService", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            guard let data = data, let message = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных в ответе"])))
                return
            }
            
            completion(.success(message))
        }.resume()
    }
    
    func forgotPassword(
        email: String,
        newPassword: String,
        confirmNewPassword: String,
        completion: @escaping (Result<String, any Error>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)/client/users/forgot-password") else {
            completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Некорректный URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let confirmPasswordCodeRequest = ConfirmPasswordModel(email: email, newPassword: newPassword, confirmNewPassword: confirmNewPassword)
        
        do {
            request.httpBody = try JSONEncoder().encode(confirmPasswordCodeRequest)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let errorMessage = "Ошибка сервера с кодом: \(statusCode)"
                completion(.failure(NSError(domain: "AuthService", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            guard let data = data, let message = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных в ответе"])))
                return
            }
            
            completion(.success(message))
        }.resume()
    }
}
