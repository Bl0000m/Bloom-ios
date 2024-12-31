import Foundation

protocol CompleteOrderViewModelProtocol {
    func moveToSubscribes()
}

class CompleteOrderViewModel: CompleteOrderViewModelProtocol {
    
    private let coordinator: CompleteOrderCoordinator
    
    init(coordinator: CompleteOrderCoordinator) {
        self.coordinator = coordinator
    }
    
    func moveToSubscribes() {
        
    }
}
