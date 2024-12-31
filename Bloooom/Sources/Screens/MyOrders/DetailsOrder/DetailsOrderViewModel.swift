import Foundation

protocol DetailsOrderViewModelProtocol: AnyObject {
    func goToGallery()
}

class DetailsOrderViewModel: DetailsOrderViewModelProtocol {
    
    private let coordinator: DetailsOrderCoordinator
    
    init(coordinator: DetailsOrderCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToGallery() {
        coordinator.moveToGallery()
    }
}
