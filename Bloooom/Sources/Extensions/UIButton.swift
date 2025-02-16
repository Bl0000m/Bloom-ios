import UIKit

extension UIButton {
    convenience init(
        title: String,
        setTitleColor: UIColor = .black,
        borderWidth: CGFloat = 0.5,
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
    
    convenience init(
        btnImage: String
    ) {
        self.init()
        self.setImage(UIImage(named: btnImage), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text: String, textColor: UIColor, font: CGFloat) {
        self.init()
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: font, weight: .regular)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(
        text: String,
        setTitleColor: UIColor = .gray,
        borderWidth: CGFloat = 0.5,
        borderColor: UIColor = .gray,
        font: CGFloat = 12
    ) {
        self.init()
        self.setTitle(text, for: .normal)
        self.setTitleColor(setTitleColor, for: .normal)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.titleLabel?.font = .systemFont(ofSize: font)
        self.isEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

