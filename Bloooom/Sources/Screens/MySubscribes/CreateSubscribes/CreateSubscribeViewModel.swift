import Foundation

protocol CreateSubscribeViewModelProtocol {
    func moveToBack()
    func createSubscribe(subscribeName: String, subscribeType: String)
    func validateSubscribeName(_ name: String) -> String?
    func validateTypeSubscribe(_ name: String) -> String?
}

class CreateSubscribeViewModel: CreateSubscribeViewModelProtocol {
    
    private let coordinator: CreateSubscribeCoordinator
    
    init(coordinator: CreateSubscribeCoordinator) {
        self.coordinator = coordinator
    }
    
    func moveToBack() {
        coordinator.moveBack()
    }
    
    func createSubscribe(subscribeName: String, subscribeType: String) {
        coordinator.createSubscribe(subscribeName: subscribeName, subscribeType: subscribeType)
    }
    
    func validateSubscribeName(_ name: String) -> String? {
        guard !name.isEmpty else {
            return "Заполните поле."
        }
        return nil
    }
    
    func validateTypeSubscribe(_ name: String) -> String? {
        guard !name.isEmpty else {
            return "Выберите тип подписки"
        }
        return nil
    }
}
