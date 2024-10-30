import UIKit

final class CreateAccountViewController: UIViewController {
    private var viewModel: CreateAccountViewModelProtocol
    
    private let checkStack = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 10)
    private let stackView = UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 5)
    private lazy var backButton = UIButton(btnImage: "btnLeft")
    private let createAccountLabel = UILabel(text: "СОЗДАТЬ АККАУНТ", font: 16, alignment: .left)
    private let nameTF = UITextField(placeHolder: "ИМЯ", keyboard: .default)
    private let nameSeparator = UIView(backgroundColor: .black)
    private let emailTF = UITextField(placeHolder: "ЭЛЕКТРОННАЯ ПОЧТА", keyboard: .emailAddress)
    private let emailSeparator = UIView(backgroundColor: .black)
    private let internationalCodeNumberTF = UITextField(placeHolder: "+7", keyboard: .numberPad)
    private let intertationalCodeSeperator = UIView(backgroundColor: .black)
    private lazy var internationalCodeButton = UIButton(btnImage: "expand")
    private let phoneNumberTF = UITextField(placeHolder: "НОМЕР ТЕЛЕФОНА", keyboard: .phonePad)
    private let phoneNumberSeperator = UIView(backgroundColor: .black)
    private let passwordTF = UITextField(placeHolder: "ПАРОЛЬ", keyboard: .default)
    private let passwordSeperator = UIView(backgroundColor: .black)
    private let repeatPasswordTF = UITextField(placeHolder: "ПОВТОРИТЕ ПАРОЛЬ", keyboard: .default)
    private let repeatPasswordSeperator = UIView(backgroundColor: .black)
    private lazy var checkBoxButton = UIButton(btnImage: "check")
    private let checkBoxRule = UILabel(
        text: "Я хочу получать информацию о приложений\nна электронную почту",
        font: 12,
        alignment: .left
    )
    private lazy var createAccountButton = UIButton(title: "СОЗДАТЬ АККАУНТ")
    
    init(viewModel: CreateAccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupButtonAction()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupButtonAction() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountAction), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc private func createAccountAction() {
        viewModel.moveToCreateAccount()
    }
    
    private func setupUI() {
        [backButton, createAccountLabel, nameTF, nameSeparator, emailTF, emailSeparator, stackView, intertationalCodeSeperator, phoneNumberTF, phoneNumberSeperator, passwordTF, passwordSeperator, repeatPasswordTF, repeatPasswordSeperator, checkStack, createAccountButton].forEach { view.addSubview($0) }
        [internationalCodeNumberTF, internationalCodeButton].forEach { stackView.addArrangedSubview($0) }
        [checkBoxButton, checkBoxRule].forEach { checkStack.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            createAccountLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            createAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createAccountLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameTF.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 40),
            nameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTF.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            nameSeparator.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 3),
            nameSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor, constant: 5),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTF.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            emailSeparator.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 3),
            emailSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor, constant: 3),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 46),
            stackView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            intertationalCodeSeperator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 3),
            intertationalCodeSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            intertationalCodeSeperator.heightAnchor.constraint(equalToConstant: 1),
            intertationalCodeSeperator.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberTF.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor, constant: 3),
            phoneNumberTF.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5),
            phoneNumberTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberTF.heightAnchor.constraint(equalToConstant: 46),
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberSeperator.topAnchor.constraint(equalTo: phoneNumberTF.bottomAnchor, constant: 3),
            phoneNumberSeperator.leadingAnchor.constraint(equalTo: intertationalCodeSeperator.trailingAnchor, constant: 5),
            phoneNumberSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: phoneNumberSeperator.bottomAnchor, constant: 5),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTF.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        NSLayoutConstraint.activate([
            passwordSeperator.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 3),
            passwordSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordTF.topAnchor.constraint(equalTo: passwordSeperator.bottomAnchor, constant: 5),
            repeatPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repeatPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repeatPasswordTF.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordSeperator.topAnchor.constraint(equalTo: repeatPasswordTF.bottomAnchor, constant: 3),
            repeatPasswordSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repeatPasswordSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repeatPasswordSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            checkStack.topAnchor.constraint(equalTo: repeatPasswordSeperator.bottomAnchor, constant: 25),
            checkStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkStack.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: checkStack.bottomAnchor, constant: 25),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createAccountButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
