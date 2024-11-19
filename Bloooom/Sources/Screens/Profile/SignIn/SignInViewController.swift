import UIKit

final class SignInViewController: UIViewController {
    private var viewModel: SignInViewModelProtocol
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnLeft"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let entryLabel = UILabel(text: "ВОЙТИ В АККАУНТ", font: 16, textColor: .black)
    private let emailLabel = UILabel(text: "ЭЛЕКТРОННАЯ ПОЧТА", font: 12, textColor: .lightGray)
    private let emailTextField = UITextField(placeHolder: "", keyboard: .emailAddress)
    private let emailSeperatorLine = UIView(backgroundColor: .lightGray)
    private let emailErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private let passwordLabel = UILabel(text: "ПАРОЛЬ", font: 12, textColor: .lightGray)
    private let passwordTextField = UITextField(placeHolder: "", keyboard: .default)
    private let passwordSeperatorLine = UIView(backgroundColor: .lightGray)
    private let passwordErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private lazy var entryButton = UIButton(title: "ВОЙТИ В АККАУНТ")
    private let notAccountLabel = UILabel(text: "НЕТ АККАУНТА?", font: 16, textColor: .black)
    private lazy var createButton = UIButton(title: "СОЗДАТЬ АККАУНТ")
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureButtonActions()
        bindViewModel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .white
        hidesBottomBarWhenPushed = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        passwordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
    
    private func hideAllErrorLabels() {
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func moveToBack() {
        viewModel.backButtonTapped()
    }
    
    @objc private func moveToForgotPassword() {
        viewModel.forgotPasswordTapped()
    }
    
    @objc private func moveToAccount() {
        hideAllErrorLabels()
        
        validateTextField(emailTextField)
        validateTextField(passwordTextField)
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        viewModel.login(username: email, password: password)
    }
    
    @objc private func moveToCreateAccount() {
        viewModel.moveToCreateAccount()
    }
    
    private func bindViewModel() {
        viewModel.didLoginSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.moveToAccount()
            }
            
        }
        
        viewModel.didLoginFailure = { errorMessage in
            print(errorMessage)
        }
    }
    
    private func configureUI() {
        [
            backButton, entryLabel, emailLabel, emailTextField, emailSeperatorLine, emailErrorLabel, passwordLabel, passwordTextField, passwordSeperatorLine, passwordErrorLabel, forgotPasswordButton, entryButton, notAccountLabel, createButton
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
            emailLabel.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            emailSeperatorLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 1),
            emailSeperatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailSeperatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailSeperatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            emailErrorLabel.topAnchor.constraint(equalTo: emailSeperatorLine.bottomAnchor, constant: 3),
            emailErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 5),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordSeperatorLine.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1),
            passwordSeperatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordSeperatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordSeperatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordSeperatorLine.bottomAnchor, constant: 3),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            entryButton.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 20),
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

extension SignInViewController: UITextFieldDelegate {
    func validateTextField(_ textField: UITextField) {
        let errorText: String?
        
        switch textField {
        case emailTextField:
            errorText = viewModel.validateEmail(emailTextField.text ?? "")
            emailErrorLabel.text = errorText
            emailErrorLabel.isHidden = (errorText == nil)
            emailSeperatorLine.backgroundColor = (emailTextField.text?.isEmpty ?? true) ? .red : .lightGray
        case passwordTextField:
            errorText = viewModel.validatePassword(passwordTextField.text ?? "")
            passwordErrorLabel.text = errorText
            passwordErrorLabel.isHidden = (errorText == nil)
            passwordSeperatorLine.backgroundColor = (passwordTextField.text?.isEmpty ?? true) ? .red : .lightGray
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateTextField(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var labelToAnimate: UILabel?
        
        switch textField {
        case emailTextField:
            labelToAnimate = emailLabel
        case passwordTextField:
            labelToAnimate = passwordLabel
        default:
            break
        }
        
        if let label = labelToAnimate {
            UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
                label.font = .systemFont(ofSize: 8, weight: .regular)
            }, completion: nil)
        }
    }
}
