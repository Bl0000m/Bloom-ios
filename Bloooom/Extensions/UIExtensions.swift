import Foundation
import UIKit


extension UIStackView {
  
  convenience init(axis: NSLayoutConstraint.Axis = .vertical,
                   distribution: UIStackView.Distribution = .fillEqually,
                   alignment: UIStackView.Alignment = .leading,
                   spacing: CGFloat) {
    self.init()
    self.axis = axis
    self.distribution = distribution
    self.alignment = alignment
    self.spacing = spacing
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

extension UIButton {
  convenience init(title: String, setTitleColor: UIColor = .black, borderWidth: CGFloat = 1, borderColor: UIColor = .black, font: CGFloat = 12) {
    self.init()
    self.setTitle(title, for: .normal)
    self.setTitleColor(setTitleColor, for: .normal)
    self.layer.borderWidth = borderWidth
    self.layer.borderColor = borderColor.cgColor
    self.titleLabel?.font = .systemFont(ofSize: font)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

extension UILabel {
  convenience init(text: String, font: CGFloat = 16, aligment: NSTextAlignment = .left, textColor: UIColor = .black, numberOfLine: Int = 0) {
    self.init()
    self.text = text
    self.font = .systemFont(ofSize: font)
    self.textAlignment = aligment
    self.textColor = textColor
    self.numberOfLines = numberOfLine
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
