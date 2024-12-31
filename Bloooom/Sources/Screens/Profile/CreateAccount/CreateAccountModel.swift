import Foundation

enum CreateAccountError: String {
    case invalidEmailFormat = "Укажите корректный адрес электронной почты."
    case emptyEmailField = "Пожалуйста, заполните поле e-mail."
    case shortPassword = "Пароль должен содержать не менее 8 символов."
    case passwordRequiresLettersAndNumbers = "Для большей безопасности пароль должен содержать как цифры, так и буквы."
    case passwordsDoNotMatch = "Проверьте правильность введенных паролей."
    case usernameInvalidCharacters = "Убедитесь, что имя пользователя не содержит запрещенных символов."
    case invalidPhoneFormat = "Введите номер телефона в международном формате."
    case nameContainsSpecialCharacters = "Имя должно состоять только из букв."
    case emptyField = "Пожалуйста, заполните все обязательные поля."
    case weakPassword = "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ."
}

struct CreateAccountModel: Codable {
    var email: String
    var password: String
    var confirmPassword: String
    var name: String
    var phoneNumber: String

    func validate() -> [CreateAccountError] {
        var errors: [CreateAccountError] = []

        if name.isEmpty {
            errors.append(.emptyField)
        } else if !isValidUsername(name) {
            errors.append(.usernameInvalidCharacters)
        }
        
        if email.isEmpty {
            errors.append(.emptyEmailField)
        } else if !isValidEmail(email) {
            errors.append(.invalidEmailFormat)
        }

        if phoneNumber.isEmpty {
            errors.append(.emptyField)
        } else if !isValidPhone(phoneNumber) {
            errors.append(.invalidPhoneFormat)
        }
        
        if password.isEmpty {
            errors.append(.emptyField)
        } else if password.count < 8 {
            errors.append(.shortPassword)
        } else if !containsLettersAndNumbers(password) {
            errors.append(.passwordRequiresLettersAndNumbers)
        } else if password != confirmPassword {
            errors.append(.passwordsDoNotMatch)
        } else if !isStrongPassword(password) {
            errors.append(.weakPassword)
        }

        return errors
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private func isStrongPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    private func containsLettersAndNumbers(_ password: String) -> Bool {
        let letterRegex = ".*[A-Za-z].*"
        let numberRegex = ".*[0-9].*"
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", letterRegex)
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return letterPredicate.evaluate(with: password) && numberPredicate.evaluate(with: password)
    }

    private func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[A-Za-z0-9]+$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }

    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^\\+?[0-9]{10,15}$" // Международный формат
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
}
