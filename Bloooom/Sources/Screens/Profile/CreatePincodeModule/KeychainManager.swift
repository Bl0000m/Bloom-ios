import Foundation
import Security

protocol KeychainManagerProtocol {
    func savePin(_ pin: String, for account: String)
    func loadPin(for account: String) -> String?
    func getSavedPin(for key: String) -> String?
}

class KeychainManager: KeychainManagerProtocol {
    static let shared = KeychainManager()
    
    private init() {}
    
    func savePin(_ pin: String, for account: String) {
        guard let pinData = pin.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.yourapp.pin",
            kSecAttrAccount as String: account,
            kSecValueData as String: pinData
        ]
        
        SecItemDelete(query as CFDictionary) // Удаляем старый PIN перед добавлением
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func loadPin(for account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.yourapp.pin",
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let data = item as? Data, let pin = String(data: data, encoding: .utf8) else {
            return nil
        }
        return pin
    }
    
    func getSavedPin(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

