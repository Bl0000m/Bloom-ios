import Foundation

protocol MySubscribesViewModelProtocol {
    func moveToBack()
    func moveToCreateSubscribe()
}

class MySubscribesViewModel: MySubscribesViewModelProtocol {
    
    private let coordinator: MySubscribesCoordinator
    
    init(coordinator: MySubscribesCoordinator) {
        self.coordinator = coordinator
    }
    
    func moveToBack() {
        coordinator.moveBack()
    }
    
    func moveToCreateSubscribe() {
        coordinator.createSubscribe()
    }
}
