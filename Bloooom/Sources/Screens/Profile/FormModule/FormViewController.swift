import UIKit

class FormViewController: UIViewController {
    
    private var model: FormViewContent
    var buttonAction: (() -> Void)?
    var backButtonAction: (() -> Void)?
    
    private let stackView = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .leading, spacing: 8)
    private let backButton = UIButton(btnImage: "btnLeft")
    private let mainTitle = UILabel(text: "", font: 16, alignment: .left, textColor: .lightGray)
    private let mainSubTitle = UILabel(text: "", font: 12, alignment: .left, textColor: .lightGray)
    private let textField = UITextField(placeHolder: "", keyboard: .default)
    private let seperatorLine = UIView(backgroundColor: .lightGray)
    private lazy var confirmButton = UIButton(title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActionButton()
        view.backgroundColor = .white
        textField.font = .systemFont(ofSize: 12, weight: .regular)
        configure(model: model)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    init(
        model: FormViewContent,
        buttonAction: (() -> Void)?,
        backButtonAction: (() -> Void)?
    ) {
        self.model = model
        self.buttonAction = buttonAction
        self.backButtonAction = backButtonAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [backButton, stackView, textField, seperatorLine, confirmButton].forEach { view.addSubview($0) }
        [mainTitle, mainSubTitle].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            seperatorLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 3),
            seperatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            seperatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor, constant: 70),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func setupActionButton() {
        confirmButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(toBackAction), for: .touchUpInside)
    }
    
    @objc private func tapAction() {
        buttonAction?()
    }
    
    @objc private func toBackAction() {
        backButtonAction?()
    }
    
    private func configure(model: FormViewContent) {
        mainTitle.text = model.title
        mainSubTitle.text = model.subtitle
        textField.placeholder = model.placeholder
        textField.keyboardType = model.keyboardType
        confirmButton.setTitle(model.actionButtonTitle, for: .normal)
        textField.isSecureTextEntry = model.isSecure
    }
}
