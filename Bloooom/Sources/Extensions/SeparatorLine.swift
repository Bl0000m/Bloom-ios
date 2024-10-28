import UIKit

extension UIView {
    convenience init(
        backgroundColor: UIColor = .black
    ) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
