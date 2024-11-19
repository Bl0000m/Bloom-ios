import Foundation

protocol PinViewModelProtocol {
    var enteredPin: String { get set }
    
    var pinSaved: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var pinUpdateHandler: ((String) -> Void)? { get set }
    
    func didPressKey(_ key: String)
    func moveToFaceID()
}

class PinViewModel: PinViewModelProtocol {
    private let createPinCoordinator: CreatePinCoordinator
    private let keychainManager: KeychainManagerProtocol
    
    var enteredPin = "" {
        didSet { pinUpdateHandler?(enteredPin) }
    }
    
    var pinSaved: (() -> Void)?
    var showError: ((String) -> Void)?
    var pinUpdateHandler: ((String) -> Void)?

    init(keychainManager: KeychainManagerProtocol = KeychainManager.shared, coordinator: CreatePinCoordinator) {
        self.keychainManager = keychainManager
        self.createPinCoordinator = coordinator
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
    
    func moveToFaceID() {
        createPinCoordinator.goToFaceId()
    }
    
    private func handlePinEntry() {
        
    }
}
