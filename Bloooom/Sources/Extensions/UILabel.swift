import UIKit

extension UILabel {
    convenience init(
        text: String,
        font: CGFloat = 16,
        alignment: NSTextAlignment = .left,
        textColor: UIColor = .black,
        numberOfLine: Int = 0
    ) {
        self.init()
        self.text = text
        self.font = .systemFont(ofSize: font)
        self.textAlignment = alignment
        self.textColor = textColor
        self.numberOfLines = numberOfLine
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
