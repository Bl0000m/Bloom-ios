import Foundation

protocol VerifyProfileViewModelProtocol {
    var items: [VerifyProfileLocal] { get }
    var onLogoutSuccess: (() -> Void)? { get set }
    var onLogoutFailure: ((String) -> Void)? { get set }
    func moveToSubscribes()
    func fetchData()
    func closeSession()
    func removeUser()
    func goToSignIn()
}

class VerifyProfileViewModel: VerifyProfileViewModelProtocol {
    
    var onLogoutSuccess: (() -> Void)?
    var onLogoutFailure: ((String) -> Void)?
    
    var items: [VerifyProfileLocal] = [
        VerifyProfileLocal(profileCategoryImage: "order", profileCategoryTitle: "Мои заказы", profileExpandImage: "expandRight"),
        VerifyProfileLocal(profileCategoryImage: "checkRing", profileCategoryTitle: "Мои подписки", profileExpandImage: "expandRight"),
        VerifyProfileLocal(profileCategoryImage: "calendar", profileCategoryTitle: "Календарь событии", profileExpandImage: "expandRight"),
        VerifyProfileLocal(profileCategoryImage: "creditCard", profileCategoryTitle: "Способы оплаты", profileExpandImage: "expandRight"),
        VerifyProfileLocal(profileCategoryImage: "world", profileCategoryTitle: "Язык приложения", profileExpandImage: "expandRight"),
        VerifyProfileLocal(profileCategoryImage: "bell", profileCategoryTitle: "Уведомления", profileExpandImage: "expandRight"),
        VerifyProfileLocal(profileCategoryImage: "groupShare", profileCategoryTitle: "Пригласить друга", profileExpandImage: "expandRight"),
        VerifyProfileLocal(profileCategoryImage: "iosApps", profileCategoryTitle: "О приложении", profileExpandImage: "expandRight")
    ]
    
    private let coordinator: VerifyProfileCoordinator
    
    init(coordinator: VerifyProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func moveToSubscribes() {
        coordinator.goToSubscribes()
    }
    
    func fetchData() {
        UserAPIManager.shared.fetchUserData(
            bearerToken: UserDefaults.standard.string(forKey: "userAccessToken")!) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let userData):
                        self?.saveUserDataToUserDefaults(userData: userData)
                    case .failure(let error):
                        print("Error - \(error.localizedDescription)")
                    }
                }
            }
    }
    
    private func saveUserDataToUserDefaults(userData: UserData) {
        let defaults = UserDefaults.standard
        
        defaults.set(userData.id, forKey: "userId")
        defaults.set(userData.name, forKey: "userName")
        defaults.set(userData.phoneNumber, forKey: "userPhoneNumber")
        defaults.set(userData.email, forKey: "userEmail")
        
        print("User data saved to UserDefaults")
    }
    
    func closeSession() {
        UserAPIManager.shared.logoutUser(bearerToken: UserDefaults.standard.string(forKey: "userAccessToken")!) { [weak self] result in
            switch result {
            case .success:
                self?.onLogoutSuccess?()
            case .failure(let error):
                self?.onLogoutFailure?(error.localizedDescription)
            }
        }
    }
    
    func removeUser() {
        UserAPIManager.shared.logoutUser(bearerToken: UserDefaults.standard.string(forKey: "userAccessToken")!) { [weak self] result in
            switch result {
            case .success:
                self?.onLogoutSuccess?()
            case .failure(let error):
                self?.onLogoutFailure?(error.localizedDescription)
            }
        }
    }
    
    func goToSignIn() {
        coordinator.goToSignIn()
    }
    
}
