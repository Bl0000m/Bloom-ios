import UIKit

class FooterView: UITableViewHeaderFooterView {

    static let footerID = "footerID"
    
    private let mainStack = UIStackView(
        axis: .vertical,
        distribution: .fillProportionally,
        alignment: .leading,
        spacing: 20
    )
    
    private let closeSessionStack = UIStackView(
        axis: .vertical,
        distribution: .fill,
        alignment: .center,
        spacing: 1
    )
    
    private let removeAccountStack = UIStackView(
        axis: .vertical,
        distribution: .fill,
        alignment: .center,
        spacing: 1
    )
    
    private lazy var closeSessionButton = UIButton(text: "Закрыть сеанс", textColor: .lightGray, font: 10)
    private let closeSeperator = UIView(backgroundColor: .lightGray)
    private lazy var removeAccountButton = UIButton(text: "Удалить свой аккаунт", textColor: .lightGray, font: 10)
    private let removeAccountSeperator = UIView(backgroundColor: .lightGray)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
        setupAction()
        mainStack.backgroundColor = .white
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(mainStack)
        [closeSessionStack, removeAccountStack].forEach { mainStack.addArrangedSubview($0) }
        [closeSessionButton, closeSeperator].forEach { closeSessionStack.addArrangedSubview($0) }
        [removeAccountButton, removeAccountSeperator].forEach { removeAccountStack.addArrangedSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            closeSeperator.heightAnchor.constraint(equalToConstant: 1),
            removeAccountSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupAction() {
        closeSessionButton.addTarget(self, action: #selector(closeSessionAction), for: .touchUpInside)
        removeAccountButton.addTarget(self, action: #selector(removeAccountAction), for: .touchUpInside)
    }
    
    @objc private func closeSessionAction() {
        
    }
    
    @objc private func removeAccountAction() {
        
    }
}
