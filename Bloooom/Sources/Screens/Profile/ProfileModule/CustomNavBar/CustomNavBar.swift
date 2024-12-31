import UIKit

class CustomNavBar: UIView {
    
    var editAction: (() -> Void)?
    private let nameLabel = UILabel(text: "", font: 16, textColor: .black)
    private lazy var editButton = UIButton(btnImage: "edit")
    private let seperatorLine = UIView(backgroundColor: .lightGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        setupAction()
        nameLabel.text = UserDefaults.standard.string(forKey: "userName")?.uppercased()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupViews() {
        [nameLabel, editButton, seperatorLine].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            seperatorLine.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            seperatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1),
           // seperatorLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupAction() {
        editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
    }
    
    @objc private func editProfile() {
        editAction?()
    }
}
