import Foundation

protocol ForgotPinPasswordViewModelProtocol {
    func resetCode(email: String)
    func validateEmail(_ email: String) -> String?
    func moveToBack()
    func moveToEmailCheckCode(email: String)
   // var onCodeConfirmed: (() -> Void)? { get set }
    var onEmailConfimed: (() -> Void)? { get set }
    var onEmailError: ((String) -> Void)? { get set }
}

class ForgotPinPasswordViewModel: ForgotPinPasswordViewModelProtocol {
    var onEmailConfimed: (() -> Void)?
    var onEmailError: ((String) -> Void)?
    
    private let coordinator: ForgotPinPasswordCoordinator
    
    
    init(coordinator: ForgotPinPasswordCoordinator) {
        self.coordinator = coordinator
    }
    
    func resetCode(email: String) {
        UserAPIManager.shared.resetCode(email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onEmailConfimed?()
                case .failure(let failure):
                    self?.onEmailError?(failure.localizedDescription)
                }
            }
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
    
    func moveToBack() {
        coordinator.goBack()
    }
    
    func moveToEmailCheckCode(email: String) {
        coordinator.checkEmailCode(email: email)
    }
}
