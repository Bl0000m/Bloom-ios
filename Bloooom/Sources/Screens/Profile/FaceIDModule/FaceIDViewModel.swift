import Foundation

protocol FaceIDViewModelProtocol {
    func goPincode()
    func goToWelcome()
}

class FaceIDViewModel: FaceIDViewModelProtocol {
    
    let coordinator: FaceIDCoordinator
    
    init(coordinator: FaceIDCoordinator) {
        self.coordinator = coordinator
    }
    
    func goPincode() {
        coordinator.goPincodeScreen()
    }
    
    func goToWelcome() {
        coordinator.moveToWelcome()
    }
}
