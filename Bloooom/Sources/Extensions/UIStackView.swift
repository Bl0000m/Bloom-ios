import UIKit

extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: UIStackView.Distribution = .fillEqually,
        alignment: UIStackView.Alignment = .leading,
        spacing: CGFloat
    ) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

