import Foundation

protocol PincodeViewModelProtocol: AnyObject {
    var enteredPin: String { get set }
    var pinUpdateHandler: ((String) -> Void)? { get set }
    func didPressKey(_ key: String)
    func moveToForgot()
    func moveToMain()
    func moveToFaceId()
    func refreshAccessToken(refreshToken: String, completion: @escaping (Result<SignInTokenResponse, Error>) -> Void)
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
    
    func moveToMain() {
        coordinator.moveToMain()
    }
    
    func refreshAccessToken(refreshToken: String, completion: @escaping (Result<SignInTokenResponse, Error>) -> Void) {
        UserAPIManager.shared.refreshAccessToken(refreshToken: refreshToken, completion: completion)
    }
    
    func moveToFaceId() {
        coordinator.goToFaceId()
    }
}

