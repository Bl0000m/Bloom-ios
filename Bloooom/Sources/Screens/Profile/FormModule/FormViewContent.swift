import Foundation
import UIKit

struct FormViewContent {
    let title: String
    let subtitle: String
    let placeholder: String
    let actionButtonTitle: String
    let keyboardType: UIKeyboardType
    let isSecure: Bool
    
    static var passwordReset: FormViewContent {
        return FormViewContent(
            title: "ЗАБЫЛИ ПАРОЛЬ",
            subtitle: "Пожалуйста, введите ваш электронный адрес\nдля сброса пароля",
            placeholder: "ЭЛЕКТРОННАЯ ПОЧТА",
            actionButtonTitle: "ПРОДОЛЖИТЬ",
            keyboardType: .emailAddress,
            isSecure: false
        )
    }
    
    static var emailVerification: FormViewContent {
        return FormViewContent(
            title: "ПРОВЕРЬТЕ СВОЮ ПОЧТУ",
            subtitle: "Мы отправили ссылку на your...@gmail.com\nВведите 4-значный код, указаный в письме",
            placeholder: "ВВЕДИТЕ КОД",
            actionButtonTitle: "ПОДТВЕРДИТЬ",
            keyboardType: .numberPad,
            isSecure: false
        )
    }
    
//    static var newPasswordCreation: FormViewContent {
//        return FormViewContent(
//            title: "ПРИДУМАЙТЕ НОВЫЙ ПАРОЛЬ",
//            subtitle: "Убедитесь, что он отличается от предыдущих\nдля безопасности",
//            placeholder: "ВВЕДИТЕ ПАРОЛЬ",
//            actionButtonTitle: "ПОДТВЕРДИТЬ",
//            keyboardType: .default,
//            isSecure: true
//        )
//    }
}
