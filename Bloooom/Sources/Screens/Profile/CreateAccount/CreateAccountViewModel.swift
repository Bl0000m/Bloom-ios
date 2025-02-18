import Foundation

protocol CreateAccountViewModelProtocol {
    
    var email: String { get set }
    var password: String { get set }
    var confirmPassword: String { get set }
    var phoneNumber: String { get set }
    var name: String { get set }
    
    var didSignUpSuccess: (() -> Void)? { get set }
    var didSignUpFailure: ((String) -> Void)? { get set }
    
    func moveToCreateAccount(email: String)
    func backButtonTapped()
    func validateRegistration() -> [CreateAccountError]
    func signUp(name: String, email: String, phoneNumber: String, password: String, confirmPassword: String)
    func selectionCountryCode(delegate: CountrySelectionDelegate)
    
    func validateEmail(_ email: String) -> String?
    func validatePassword(_ password: String) -> String?
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> String?
    func validateUsername(_ username: String) -> String?
    func validatePhoneNumber(_ phoneNumber: String) -> String?
    func isValidPhoneNumber(_ phone: String) -> Bool
    func validateName(_ name: String) -> String?
}

final class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    var didSignUpSuccess: (() -> Void)?
    var didSignUpFailure: ((String) -> Void)?
    var reloadTableView: (() -> Void)?
    
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var phoneNumber: String = ""
    var name: String = ""
    
 
    private weak var createAccountCoordinator: CreateAccountCoordinator?
    
    init(createAccountCoordinator: CreateAccountCoordinator?) {
        self.createAccountCoordinator = createAccountCoordinator
    }
    
    func backButtonTapped() {
        createAccountCoordinator?.moveToBack()
    }
    
    func moveToCreateAccount(email: String) {
        createAccountCoordinator?.moveToCreateAccount(email: email)
    }
    
    private var registrationModel: CreateAccountModel {
        return CreateAccountModel(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            name: name,
            phoneNumber: phoneNumber
        )
    }
    
    func validateRegistration() -> [CreateAccountError] {
        return registrationModel.validate()
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
            return "Минимум 8 символов"
        }
        
        let digitRegex = ".*[0-9]+.*"
        let letterRegex = ".*[A-Za-z]+.*"
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", letterRegex)
        
        if !digitPredicate.evaluate(with: password) || !letterPredicate.evaluate(with: password) {
            return "Используйте буквы и цифры"
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
            return "Используйте буквы и цифры"
        }
        
        return nil
    }
    
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> String? {
        guard password == confirmPassword else {
            return "Пароль и подтверждение пароля не совпадают: Проверьте правильность введенных паролей."
        }
        return nil
    }
    
    func validateUsername(_ username: String) -> String? {
        let usernameRegex = "^[A-Za-zА-Яа-яЁё0-9]+$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        
        if !usernamePredicate.evaluate(with: username) {
            return "Используйте только буквы и цифры"
        }
        return nil
    }

    func validatePhoneNumber(_ phoneNumber: String) -> String? {
        let phoneNumberRegex = "^\\d{10,15}$" // 10-15 цифр без знака "+" и кода страны
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        
        if !phoneNumberPredicate.evaluate(with: phoneNumber) {
            return "Введите номер в международном формате"
        }
       
        return nil
    }
    
    func isValidPhoneNumber(_ phone: String) -> Bool {
        let cleanedPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return cleanedPhone.count >= 10 && cleanedPhone.count <= 12
    }
    
    func validateName(_ name: String) -> String? {
        let nameRegex = "^[A-Za-zА-Яа-я]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        if !namePredicate.evaluate(with: name) {
            return "Имя не может содержать специальные символы: Имя должно состоять только из букв."
        }
        if name.count < 3 {
            return "Минимальная длина поля имени - 3 символа: Имя должно содержать не менее 3 символов."
        }
        return nil
    }
    
    func signUp(name: String, email: String, phoneNumber: String, password: String, confirmPassword: String) {
        let signUpModel = CreateUserModel(
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            confirmPassword: confirmPassword
        )
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(signUpModel)
            
            UserAPIManager.shared.signUpData(to: "/client/users", parameters: jsonData) { [weak self] result in
                switch result {
                case .success(let response):
                    // Попытка декодировать ошибку, если она есть
                    do {
                        let decoder = JSONDecoder()
                        if let errorResponse = try? decoder.decode(ErrorResponse.self, from: response) {
                            // Если удалось декодировать ошибку, обрабатываем её
                            switch errorResponse.code {
                            case "USER_EMAIL_ALREADY_EXIST":
                                let errorMessage = "Этот email уже используется"
                                print("❌ \(errorMessage)")
                                self?.didSignUpFailure?(errorMessage)
                            case "USER_PHONE_NUMBER_ALREADY_EXIST":
                                let errorMessage = "Номер телефона уже зарегистрирован"
                                print("❌ \(errorMessage)")
                                self?.didSignUpFailure?(errorMessage)
                            default:
                                print("❌ Ошибка с сервера: \(errorResponse.message)")
                                self?.didSignUpFailure?(errorResponse.message)
                            }
                        } else {
                            // Если не удалось декодировать ошибку, считаем, что регистрация успешна
                            print("✅ Регистрация успешна")
                            self?.didSignUpSuccess?()
                        }
                    } catch {
                        print("❌ Ошибка при обработке JSON-ответа: \(error.localizedDescription)")
                        self?.didSignUpFailure?("Ошибка при обработке JSON-ответа")
                    }
                    
                case .failure(let error):
                    print("❌ Ошибка запроса: \(error.localizedDescription)")
                    self?.didSignUpFailure?(error.localizedDescription)
                }
            }
        } catch {
            print("❌ Ошибка кодирования параметров: \(error.localizedDescription)")
            self.didSignUpFailure?(error.localizedDescription)
        }
    }



    func selectionCountryCode(delegate: CountrySelectionDelegate) {
        createAccountCoordinator?.startCountrySelectionFlow(delegate: delegate)
    }
}



//do {
//    let encoder = JSONEncoder()
//    let jsonData = try encoder.encode(signUpModel)
//
//    UserAPIManager.shared.signUpData(to: "/client/users", parameters: jsonData) { [weak self] result in
//        switch result {
//        case .success(let response):
//            if let json = try? JSONSerialization.jsonObject(with: response, options: []) as? [String: Any] {
//                if let errorCode = json["code"] as? String {
//                    // Проверяем код ошибки
//                    if errorCode == "USER_EMAIL_ALREADY_EXIST" {
//                        let errorMessage = "Этот email уже используется"
//                        print("❌ \(errorMessage)")
//                        self?.didSignUpFailure?(errorMessage)
//                    } else if errorCode == "USER_PHONE_NUMBER_ALREADY_EXIST" {
//                        let errorMessage = "Неверный формат номера телефона. Пожалуйста, введите корректный номер."
//                        print("❌ \(errorMessage)")
//                        self?.didSignUpFailure?(errorMessage)
//                    } else {
//                        if let message = json["message"] as? String {
//                            print("❌ Ошибка с сервера: \(message)")
//                            self?.didSignUpFailure?(message)
//                        }
//                    }
//                } else {
//                    print("✅ Регистрация успешна")
//                    self?.didSignUpSuccess?()
//                }
//            } else {
//                print("❌ Некорректный JSON-ответ")
//                self?.didSignUpFailure?("Некорректный JSON-ответ")
//            }
//
//        case .failure(let error):
//            print("❌ Ошибка запроса: \(error.localizedDescription)")
//            self?.didSignUpFailure?(error.localizedDescription)
//        }
//    }
//} catch {
//    print("❌ Ошибка кодирования параметров: \(error.localizedDescription)")
//    didSignUpFailure?(error.localizedDescription)
//}
