import Foundation

protocol CalendarViewModelProtocol {
    func moveBack()
    func moveToCalendar()
    func moveToCompleteOrder(selectedDates: [Date])
    func sendSubscription(
        dates: [Date],
        startTime: String,
        endTime: String,
        completion: @escaping (Result<ResponseData, Error>) -> Void
    )
    
}

class CalendarViewModel: CalendarViewModelProtocol {
    
    private let coordinator: CalendarCoordinator
    
    init(coordinator: CalendarCoordinator) {
        self.coordinator = coordinator
    }
    
    func moveBack() {
        coordinator.goBack()
    }
    
    func moveToCalendar() {
        coordinator.goCalendar()
    }
    
    func moveToCompleteOrder(selectedDates: [Date]) {
        coordinator.goToOrderDetails(data: selectedDates)
    }
    
    func sendSubscription(
        dates: [Date],
        startTime: String,
        endTime: String,
        completion: @escaping (Result<ResponseData, Error>) -> Void
    ) {
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        guard let nameSubscription = defaults.string(forKey: "nameSubscribe"),
              let accessToken = defaults.string(forKey: "userAccessToken") else {
            return
        }
        
        print("Access Token: \(accessToken)")
        
        // Настроим DateFormatter для преобразования Date в строку в нужном формате
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"  // Формат для даты (можно настроить)
        
        // Преобразуем массив Date в массив строк
        let formattedDates = dates.map { dateFormatter.string(from: $0) }
        
        // Создаем модель подписки с отформатированными датами
        let subscription = CreateSubscribeModel(
            userId: userId,
            name: nameSubscription,
            subscriptionTypeId: 1,
            orderDates: formattedDates.map { OrderDates(orderDate: $0, orderStartTime: startTime, orderEndTime: endTime) }
        )
        
        print("Subscription Model: \(subscription)")
        
        // Отправляем запрос
        MySubscribeAPIManager.shared.createSubscription(model: subscription, accessToken: accessToken) { result in
            // Здесь вызываем completion на главном потоке
            DispatchQueue.main.async {
                completion(result)
            }
        }

    }
}
