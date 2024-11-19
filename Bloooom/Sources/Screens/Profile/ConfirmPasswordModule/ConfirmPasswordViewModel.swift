import Foundation

protocol ConfirmPasswordViewModelProtocol {
    func confirmPassword(email: String, password: String, confirmPassword: String)
    func validatePassword(_ password: String) -> String?
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> String?
    func moveToMain()
    
    var didCheckEmailSuccess: (() -> Void)? { get set }
    var didCheckEmailFailure: ((String) -> Void)? { get set }
}

class ConfirmPasswordViewModel: ConfirmPasswordViewModelProtocol {
    
    var didCheckEmailSuccess: (() -> Void)?
    var didCheckEmailFailure: ((String) -> Void)?
    
    private let coordinator: ConfrimPasswordCoordinator
    
    init(coordinator: ConfrimPasswordCoordinator) {
        self.coordinator = coordinator
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
        
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let lowercaseLetterRegex = ".*[a-z]+.*"
        let specialCharacterRegex = ".*[!@#$&*]+.*"
        let uppercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
        let lowercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex)
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        
        if !uppercaseLetterPredicate.evaluate(with: password) ||
            !lowercaseLetterPredicate.evaluate(with: password) ||
            !specialCharacterPredicate.evaluate(with: password) {
            return "Слишком слабый пароль: Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ."
        }
        
        return nil
    }
    
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> String? {
        guard password == confirmPassword else {
            return "Пароль и подтверждение пароля не совпадают: Проверьте правильность введенных паролей."
        }
        return nil
    }
    
    func confirmPassword(email: String, password: String, confirmPassword: String) {
        UserAPIManager.shared.forgotPassword(
            email: email,
            newPassword: password,
            confirmNewPassword: confirmPassword
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.didCheckEmailSuccess?()
                case .failure(let failure):
                    self?.didCheckEmailFailure?(failure.localizedDescription)
                }
            }
        }
    }
    
    func moveToMain() {
        coordinator.goToMain()
    }
    
}
