import Foundation

protocol SignInViewModelProtocol {
    func moveToAccount()
    func moveToCreateAccount()
    func backButtonTapped()
    func forgotPasswordTapped()
    func login(username: String, password: String)
    
    func validateEmail(_ email: String) -> String?
    func validatePassword(_ password: String) -> String?
    
    var didLoginSuccess: (() -> Void)? { get set }
    var didLoginFailure: ((String) -> Void)? { get set }
}

final class SignInViewModel: SignInViewModelProtocol {
    
    var didLoginSuccess: (() -> Void)?
    var didLoginFailure: ((String) -> Void)?
 
    private weak var coordinator: ProfileCoordinator?
    
    init(coordinator: ProfileCoordinator?) {
        self.coordinator = coordinator
    }
    
    func moveToAccount() {
        coordinator?.moveToAccount()
    }
    
    func moveToCreateAccount() {
        coordinator?.moveToCreateAccount()
    }
    
    func backButtonTapped() {
        coordinator?.backButtonTapped()
    }
    
    func forgotPasswordTapped() {
        coordinator?.forgotPasswordTapped()
    }
    
    func login(username: String, password: String) {
        // Создаем экземпляр модели SignInModel
        let signInModel = SignInModel(username: username, password: password)
        
        do {
            // Преобразуем SignInModel в JSON
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(signInModel)
            let parameters = (try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any])!
            
            // Отправляем запрос с сериализованными параметрами
            UserAPIManager.shared.postRequest(to: "/users/login", parameters: parameters) { [weak self] result in
                switch result {
                case .success(let response):
                    print("Response JSON:", response)
                    self?.didLoginSuccess?()  // Вызов успеха
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                    self?.didLoginFailure?(error.localizedDescription)  // Вызов ошибки
                }
            }
        } catch {
            print("Error encoding parameters: \(error.localizedDescription)")
        }
    }
    
    func validateEmail(_ email: String) -> String? {
        guard !email.isEmpty else {
            return "Поле e-mail не может быть пустым: Пожалуйста, заполните поле e-mail."
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            return "Неправильный формат e-mail: Укажите корректный адрес электронной почты."
        }
        
        return nil
    }
    
    func validatePassword(_ password: String) -> String? {
        guard !password.isEmpty else {
            return "Поле пароля не может быть пустым."
        }
        
        if password.count < 8 {
            return "Пароль слишком короткий: Пароль должен содержать не менее 8 символов."
        }
        
        let digitRegex = ".*[0-9]+.*"
        let letterRegex = ".*[A-Za-z]+.*"
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", letterRegex)
        
        if !digitPredicate.evaluate(with: password) || !letterPredicate.evaluate(with: password) {
            return "Пароль должен содержать цифры и буквы: Для большей безопасности пароль должен содержать как цифры, так и буквы."
        }
        
        return nil
    }
}
