import Foundation

protocol FaceIDViewModelProtocol {
    func goPincode()
}

class FaceIDViewModel: FaceIDViewModelProtocol {
    
    let coordinator: FaceIDCoordinator
    
    init(coordinator: FaceIDCoordinator) {
        self.coordinator = coordinator
    }
    
    func goPincode() {
        coordinator.goPincodeScreen()
    }
}
