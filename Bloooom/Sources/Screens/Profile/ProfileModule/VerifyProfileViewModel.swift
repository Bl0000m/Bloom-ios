import Foundation

protocol VerifyProfileViewModelProtocol {
    var items: [VerifyProfileLocal] { get }
    func moveToSubscribes()
    func fetchData()
}

class VerifyProfileViewModel: VerifyProfileViewModelProtocol {
    
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
}
