import UIKit

class ConfirmPasswordViewController: UIViewController {

    private var viewModel: ConfirmPasswordViewModelProtocol
    var email: String
    
    private let stackView = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 10
    )
    
    private let backButton = UIButton(btnImage: "btnLeft")
    private let createNewPasswordLabel = UILabel(text: "ПРИДУМАЙТЕ НОВЫЙ ПАРОЛЬ", font: 16, textColor: .black)
    private let descriptionCreateNewPassword = UILabel(
        text: "Убедитесь, что он отличается от предыдущих\nдля безопасности",
        font: 12,
        textColor: .lightGray
    )
    
    private let passwordLabel = UILabel(text: "ВВЕДИТЕ ПАРОЛЬ", font: 12, textColor: .lightGray)
    private let passwordTF = UITextField(placeHolder: "", keyboard: .default)
    private let passwordSeperator = UIView(backgroundColor: .lightGray)
    private let passwordErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    
    private let repeatPasswordLabel = UILabel(text: "ПОВТОРИТЕ ПАРОЛЬ", font: 12, textColor: .lightGray)
    private let repeatPasswordTF = UITextField(placeHolder: "", keyboard: .default)
    private let repeatPasswordSeperator = UIView(backgroundColor: .lightGray)
    private let repeatPasswordErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    
    private let confirmButton = UIButton(title: "ПОДТВЕРДИТЬ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayout()
        setupAction()
        setDelegatesTextField()
        hideAllErrorLabels()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    init(viewModel: ConfirmPasswordViewModelProtocol, email: String) {
        self.viewModel = viewModel
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupViews() {
        [backButton, stackView, passwordLabel, passwordTF, passwordSeperator, passwordErrorLabel, repeatPasswordLabel, repeatPasswordTF, repeatPasswordSeperator, repeatPasswordErrorLabel, confirmButton].forEach { view.addSubview($0) }
        
        [createNewPasswordLabel, descriptionCreateNewPassword].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            passwordTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordSeperator.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 1),
            passwordSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            passwordSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            passwordSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordSeperator.bottomAnchor, constant: 3),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordLabel.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 5),
            repeatPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordTF.topAnchor.constraint(equalTo: repeatPasswordLabel.bottomAnchor),
            repeatPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            repeatPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            repeatPasswordTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordSeperator.topAnchor.constraint(equalTo: repeatPasswordTF.bottomAnchor, constant: 1),
            repeatPasswordSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            repeatPasswordSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            repeatPasswordSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordErrorLabel.topAnchor.constraint(equalTo: repeatPasswordSeperator.bottomAnchor, constant: 3),
            repeatPasswordErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            repeatPasswordErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: repeatPasswordErrorLabel.bottomAnchor, constant: 25),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            confirmButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func bindViewModel(email: String) {
        viewModel.didCheckEmailSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.moveToMain()
            }
        }
        
        viewModel.didCheckEmailFailure = { error in
            print(error)
        }
    }
    
    private func setupAction() {
        confirmButton.addTarget(self, action: #selector(moveToSuccess), for: .touchUpInside)
    }
    
    @objc private func moveToSuccess() {
        hideAllErrorLabels()
        
        let textFields = [passwordTF, repeatPasswordTF]
        textFields.forEach { validateTextField($0) }
        
        guard let password = passwordTF.text, !password.isEmpty,
              let repeatePassword = repeatPasswordTF.text, !repeatePassword.isEmpty else {
            return
        }
        
        viewModel.confirmPassword(email: email, password: password, confirmPassword: repeatePassword)
        
        if password == repeatePassword {
            bindViewModel(email: email)
        }
    }
    
    private func hideAllErrorLabels() {
        passwordErrorLabel.isHidden = true
        repeatPasswordErrorLabel.isHidden = true
    }
    
    private func setDelegatesTextField() {
        passwordTF.delegate = self
        repeatPasswordTF.delegate = self
    }
}

extension ConfirmPasswordViewController: UITextFieldDelegate {
    func validateTextField(_ textField: UITextField) {
        let errorText: String?
        
        switch textField {
        case passwordTF:
            errorText = viewModel.validatePassword(passwordTF.text ?? "")
            passwordErrorLabel.text = errorText
            passwordErrorLabel.isHidden = (errorText == nil)
            passwordSeperator.backgroundColor = (passwordTF.text?.isEmpty ?? true) ? .red : .lightGray
        case repeatPasswordTF:
            errorText = viewModel.validateConfirmPassword(passwordTF.text ?? "", repeatPasswordTF.text ?? "")
            repeatPasswordErrorLabel.text = errorText
            repeatPasswordErrorLabel.isHidden = (errorText == nil)
            repeatPasswordSeperator.backgroundColor = (repeatPasswordTF.text?.isEmpty ?? true) ? .red : .lightGray
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateTextField(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTF {
            repeatPasswordTF.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var labelToAnimate: UILabel?
        
        switch textField {
        case passwordTF:
            labelToAnimate = passwordLabel
        case repeatPasswordTF:
            labelToAnimate = repeatPasswordLabel
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
