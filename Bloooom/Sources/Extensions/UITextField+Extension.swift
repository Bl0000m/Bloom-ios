import UIKit

extension UITextField {
    convenience init(
        placeHolder: String,
        placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12)
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

