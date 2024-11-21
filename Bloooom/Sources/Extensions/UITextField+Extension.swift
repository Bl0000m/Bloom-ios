import UIKit

extension UITextField {
    convenience init(
        placeHolder: String,
        placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1),
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ],
        keyboard: UIKeyboardType,
        textColor: UIColor = .black,
        textAlignment: NSTextAlignment = .left
    ) {
        self.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: placeholderAttributes)
        self.keyboardType = keyboard
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

