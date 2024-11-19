import UIKit

extension UILabel {
    convenience init(
        text: String,
        font: CGFloat,
        alignment: NSTextAlignment = .left,
        textColor: UIColor,
        numberOfLine: Int = 0
    ) {
        self.init()
        self.text = text
        self.font = .systemFont(ofSize: font, weight: .regular)
        self.textAlignment = alignment
        self.textColor = textColor
        self.numberOfLines = numberOfLine
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
