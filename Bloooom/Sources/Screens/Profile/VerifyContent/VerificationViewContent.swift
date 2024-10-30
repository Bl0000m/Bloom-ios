import Foundation

struct VerificationViewContent {
    let title: String
    let subtitle: String
    let imageName: String
    let buttonTitle: String
    
    static var success: VerificationViewContent {
        return VerificationViewContent(
            title: "ДОБРО ПОЖАЛОВАТЬ",
            subtitle: "Вы успешно прошли аутентификацию",
            imageName: "Success",
            buttonTitle: "ПРОДОЛЖИТЬ"
        )
    }
    
    static var failure: VerificationViewContent {
        return VerificationViewContent(
            title: "ОШИБКА",
            subtitle: "К сожалению, произошла ошибка. Попробуйте снова\nили обратитесь в службу поддержки, если проблема\nсохраняется.",
            imageName: "Error",
            buttonTitle: "ПОПРОБОВАТЬ СНОВА"
        )
    }
    
    static var passwordChanged: VerificationViewContent {
        return VerificationViewContent(
            title: "ПОЗДРАВЛЯЕМ",
            subtitle: "Ваш пароль был изменён. Нажмите \"Продолжить\",\nчтобы войти в систему",
            imageName: "Success",
            buttonTitle: "ПРОДОЛЖИТЬ"
        )
    }
}
