import UIKit

extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat
    ) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addArrangedSubview)
    }
    
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview)
    }
}


