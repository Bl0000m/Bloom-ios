import Foundation

protocol PincodeViewModelProtocol: AnyObject {
    var enteredPin: String { get set }
    var pinUpdateHandler: ((String) -> Void)? { get set }
    func didPressKey(_ key: String)
    func moveToForgot()
}

class PincodeViewModel: PincodeViewModelProtocol {
    
    private let pinKey = "userPin"
    
    private let coordinator: PincodeCoordinator
    
    var pinUpdateHandler: ((String) -> Void)?
    
    var enteredPin = "" {
        didSet { pinUpdateHandler?(enteredPin) }
    }
    
    init(coordinator: PincodeCoordinator) {
        self.coordinator = coordinator
    }
    
    func didPressKey(_ key: String) {
        switch key {
        case "Удалить":
            guard !enteredPin.isEmpty else { return }
            enteredPin.removeLast()
        default:
            enteredPin = enteredPin + key
            print("\(enteredPin)")
        }
    }
    
    func moveToForgot() {
        coordinator.goForgotPassword()
    }
    
}
