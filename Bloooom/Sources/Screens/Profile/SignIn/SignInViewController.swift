import UIKit

final class SignInViewController: UIViewController {
    private var viewModel: SignInViewModelProtocol
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnLeft"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let entryLabel = UILabel(text: "ВОЙТИ В АККАУНТ")
    
    private let emailTextField: UITextField = {
        let emailTF = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        let placeHolderText = "ЭЛЕКТРОННАЯ ПОЧТА"
        emailTF.borderStyle = .none
        emailTF.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: placeholderAttributes)
        emailTF.keyboardType = .emailAddress
        emailTF.textColor = .black
        emailTF.textAlignment = .left
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        return emailTF
    }()
    
    private let emailSeperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.borderStyle = .none
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        let placeHolderText = "ПАРОЛЬ"
        passwordTF.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: placeholderAttributes)
        passwordTF.textColor = .black
        passwordTF.textAlignment = .left
        passwordTF.isSecureTextEntry = true
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        return passwordTF
    }()
    
    private let passwordSeperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var entryButton = UIButton(title: "ВОЙТИ В АККАУНТ")
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let notAccountLabel = UILabel(text: "НЕТ АККАУНТА?")
    
    private lazy var createButton = UIButton(title: "СОЗДАТЬ АККАУНТ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureButtonActions()
        
        view.backgroundColor = .white
        hidesBottomBarWhenPushed = true
    }
    
    init(viewModel: SignInViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButtonActions() {
        backButton.addTarget(self, action: #selector(moveToBack), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(moveToForgotPassword), for: .touchUpInside)
        entryButton.addTarget(self, action: #selector(moveToAccount), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(moveToCreateAccount), for: .touchUpInside)
    }
    
    @objc private func moveToBack() {
        viewModel.backButtonTapped()
    }
    
    @objc private func moveToForgotPassword() {
        viewModel.forgotPasswordTapped()
    }
    
    @objc private func moveToAccount() {
        viewModel.moveToAccount()
    }
    
    @objc private func moveToCreateAccount() {
        viewModel.moveToCreateAccount()
    }
    
    private func configureUI() {
        [
            backButton, entryLabel, emailTextField, emailSeperatorLine, passwordTextField, passwordSeperatorLine,
            forgotPasswordButton, entryButton, notAccountLabel, createButton
        ].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            entryLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            entryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            entryLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            emailSeperatorLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3),
            emailSeperatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailSeperatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailSeperatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailSeperatorLine.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            passwordSeperatorLine.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3),
            passwordSeperatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordSeperatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordSeperatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            entryButton.topAnchor.constraint(equalTo: passwordSeperatorLine.bottomAnchor, constant: 20),
            entryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            entryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            entryButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: entryButton.bottomAnchor, constant: 10),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            notAccountLabel.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 120),
            notAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notAccountLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: notAccountLabel.bottomAnchor, constant: 20),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

extension SignInViewController: TabView {
    var tabInfo: Tab {
        .profile
    }
}
