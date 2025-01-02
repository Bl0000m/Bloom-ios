import Foundation

protocol DetailOrdersServiceProtocol: AnyObject {
    func fetchBouquets(accessToken: String, completion: @escaping (Result<[Bouquet], Error>) -> Void)
    func fetchBouquetPhoto(id: Int, accessToken: String, completion: @escaping (Result<BouquetDetailsModel, Error>) -> Void)
}

class DetailOrdersService: DetailOrdersServiceProtocol {
    
    private let baseURL = "http://api.bloooom.kz:8443/v1"
    static let shared = DetailOrdersService()
    private init() {}
    
    func fetchBouquets(accessToken: String, completion: @escaping (Result<[Bouquet], Error>) -> Void) {
           guard let url = URL(string: "\(baseURL)/bouquet") else {
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
                let orderDetailsArray = try JSONDecoder().decode([Bouquet].self, from: data)
                completion(.success(orderDetailsArray))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchBouquetPhoto(id: Int, accessToken: String, completion: @escaping (Result<BouquetDetailsModel, Error>) -> Void) {
        // Формирование URL
        guard let url = URL(string: "\(baseURL)/bouquet/\(id)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Запуск задачи
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Обработка ошибки соединения
            if let error = error {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Connection error: \(error.localizedDescription)"])))
                return
            }
            
            // Проверка на корректность HTTP-ответа
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            // Проверка статуса HTTP-кода
            guard httpResponse.statusCode == 200 else {
                let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))"])
                completion(.failure(error))
                return
            }
            
            // Проверка на наличие данных
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // Декодирование JSON
            do {
                let bouquetDetails = try JSONDecoder().decode(BouquetDetailsModel.self, from: data)
                completion(.success(bouquetDetails))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
