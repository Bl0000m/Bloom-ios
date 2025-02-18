import Foundation

protocol UserAPIManagerProtocol {
    func postRequest(to endpoint: String, parameters: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void)
    func signUpData(to endpoint: String, parameters: Data, completion: @escaping (Result<Data, Error>) -> Void)
    func loadCountries(completion: @escaping (Result<[Country], Error>) -> Void)
    func confirmCode(email: String, code: String, completion: @escaping (Result<String, Error>) -> Void)
    func resetCode(email: String, completion: @escaping (Result<String, Error>) -> Void)
    func refreshAccessToken(refreshToken: String, completion: @escaping (Result<SignInTokenResponse, Error>) -> Void)
    func forgotPassword(email: String, newPassword: String, confirmNewPassword: String, completion: @escaping (Result<String, Error>) -> Void)
    func fetchUserData(bearerToken: String, completion: @escaping (Result<UserData, Error>) -> Void)
    func logoutUser(bearerToken: String, completion: @escaping (Result<Void, Error>) -> Void) }

class UserAPIManager: UserAPIManagerProtocol {
    
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
                    if let token = json["accessToken"] as? String {
                        UserDefaults.standard.set(token, forKey: "userAccessToken")
                        UserDefaults.standard.synchronize()
                    }
                    
                    if let refreshToken = json["refreshToken"] as? String {
                        UserDefaults.standard.set(refreshToken, forKey: "userRefreshToken")
                        UserDefaults.standard.synchronize()
                    }
                    
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
    
    func refreshAccessToken(refreshToken: String, completion: @escaping (Result<SignInTokenResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/refresh") else {
            completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let requestBody = RefreshAccessTokenRequestBody(refreshToken: refreshToken)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(SignInTokenResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchUserData(bearerToken: String, completion: @escaping (Result<UserData, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/me") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let userData = try JSONDecoder().decode(UserData.self, from: data)
                completion(.success(userData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func logoutUser(bearerToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // URL for the logout endpoint
        guard let url = URL(string: baseURL + "/users/logout") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"  // Assuming it's a POST request for logout
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        // Add any necessary headers here (e.g., authorization token)
        // request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Perform the network request using URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            // Check if the response is valid (e.g., HTTP status code 200)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Logout failed", code: 401, userInfo: nil)))
                }
                return
            }
            
            // Remove user access token from UserDefaults
            UserDefaults.standard.removeObject(forKey: "userAccessToken")
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }.resume()
    }

}


