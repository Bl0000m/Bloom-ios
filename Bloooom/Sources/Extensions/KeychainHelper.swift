import Foundation
import KeychainSwift

protocol KeychainHelperProtocol {
    func savePassword(_ password: String, for email: String)
    func getPassword(for email: String) -> String?
}

class KeychainHelper: KeychainHelperProtocol {
    private let keychain = KeychainSwift()
    
    func savePassword(_ password: String, for email: String) {
        // Сохраняем пароль в Keychain
        keychain.set(password, forKey: email)
    }
    
    func getPassword(for email: String) -> String? {
        // Извлекаем пароль из Keychain
        return keychain.get(email)
    }
}
