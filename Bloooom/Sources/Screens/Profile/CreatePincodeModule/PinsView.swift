import UIKit

final class PinsView: UIView {
    let pinStackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .center,
        spacing: 8
    )
    
    let confirmPinStackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .center,
        spacing: 8
    )
    
    let warningPinStackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .center,
        spacing: 8
    )
    
    let successPinStack = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .center,
        spacing: 8
    )
    
    var pinView = UIView()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        return stackView
    }()
    
    var previousPinCount: Int? = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        mainStackView.addArrangedSubviews(confirmPinStackView, pinStackView, successPinStack, warningPinStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupViews() {
        pinStackView.addSubviews(createPinViews())
        confirmPinStackView.addSubviews(createPinViews())
        warningPinStackView.addSubviews(createWarningViews())
        successPinStack.addSubviews(createSuccessViews())
        warningPinStackView.isHidden = true
        confirmPinStackView.isHidden = true
        successPinStack.isHidden = true
    }
    
    private func createPinViews() -> [UIView] {
        [UIView(), UIView(), UIView(), UIView()].map { view in
            view.backgroundColor = .lightGray
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            view.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return view
        }
    }
    
    func createWarningViews() -> [UIView] {
        [UIView(), UIView(), UIView(), UIView()].map { view in
            view.backgroundColor = .red
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            view.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return view
        }
    }
    
    func createSuccessViews() -> [UIView] {
        [UIView(), UIView(), UIView(), UIView()].map { view in
            view.backgroundColor = .systemGreen
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            view.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return view
        }
    }
    
}


