import UIKit

extension UIButton {
    convenience init(
        title: String,
        setTitleColor: UIColor = .black,
        borderWidth: CGFloat = 1,
        borderColor: UIColor = .black,
        font: CGFloat = 12
    ) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(setTitleColor, for: .normal)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.titleLabel?.font = .systemFont(ofSize: font)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

