import UIKit

final class CreateAccountViewController: UIViewController {
    
    private var viewModel: CreateAccountViewModelProtocol
    private let checkStack = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 10)
    private let stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 0)
    private lazy var backButton = UIButton(btnImage: "btnLeft")
    private let createAccountLabel = UILabel(text: "СОЗДАТЬ АККАУНТ", font: 16, alignment: .left, textColor: .black)
    private let nameLabel = UILabel(text: "ИМЯ", font: 12, textColor: .lightGray)
    private let nameTF = UITextField(placeHolder: "", keyboard: .default)
    private let nameSeparator = UIView(backgroundColor: .lightGray)
    private let nameErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private let emailLabel = UILabel(text: "ЭЛЕКТРОННАЯ ПОЧТА", font: 12, textColor: .lightGray)
    private let emailTF = UITextField(placeHolder: "", keyboard: .emailAddress)
    private let emailSeparator = UIView(backgroundColor: .lightGray)
    private let emailErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private let internationalCodeNumberTF = UITextField(placeHolder: "+7", keyboard: .phonePad)
    private let intertationalCodeSeperator = UIView(backgroundColor: .lightGray)
    private lazy var internationalCodeButton = UIButton(btnImage: "expand")
    private let phoneNumberLabel = UILabel(text: "НОМЕР ТЕЛЕФОНА", font: 12, textColor: .lightGray)
    private let phoneNumberTF = UITextField(placeHolder: "", keyboard: .phonePad)
    private let phoneNumberSeperator = UIView(backgroundColor: .lightGray)
    private let phoneNumberErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private let passwordLabel = UILabel(text: "ПАРОЛЬ", font: 12, textColor: .lightGray)
    private let passwordTF = UITextField(placeHolder: "", keyboard: .default)
    private let passwordSeperator = UIView(backgroundColor: .lightGray)
    private let passwordErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private let repeatPasswordLabel = UILabel(text: "ПОВТОРИТЕ ПАРОЛЬ", font: 12, textColor: .lightGray)
    private let repeatPasswordTF = UITextField(placeHolder: "", keyboard: .default)
    private let repeatPasswordSeperator = UIView(backgroundColor: .lightGray)
    private let repeatPasswordErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private lazy var checkBoxButton = UIButton(btnImage: "check")
    private let checkBoxRule = UILabel(
        text: "Я хочу получать информацию о приложений\nна электронную почту",
        font: 12,
        alignment: .left,
        textColor: .black
    )
    private lazy var createAccountButton = UIButton(title: "СОЗДАТЬ АККАУНТ")
    private var cobmbineNumber = ""
    
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
        setDelegatesTextField()
        hideAllErrorLabels()
        setupKeyboardNotifications()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        navigationController?.setNavigationBarHidden(true, animated: false)
        internationalCodeButton.addTarget(self, action: #selector(countryTextFieldTapped), for: .touchUpInside)
        internationalCodeNumberTF.isUserInteractionEnabled = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
     
    @objc func countryTextFieldTapped() {
        viewModel.selectionCountryCode(delegate: self)
    }
    
    private func setupButtonAction() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountAction), for: .touchUpInside)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc private func createAccountAction() {
        hideAllErrorLabels()
        
        let textFields = [emailTF, passwordTF, repeatPasswordTF, phoneNumberTF, nameTF]
        textFields.forEach { validateTextField($0) }

        let combineNumber = cobmbineNumber + phoneNumberTF.text!
        guard let email = emailTF.text, !email.isEmpty,
              let password = passwordTF.text, !password.isEmpty,
              let name = nameTF.text, !name.isEmpty,
              let repeatPassword = repeatPasswordTF.text, !repeatPassword.isEmpty,
              !combineNumber.isEmpty
        else {
            return
        }

        viewModel.signUp(
            name: name,
            email: email,
            phoneNumber: combineNumber,
            password: password,
            confirmPassword: repeatPassword
        )
        
        if password == repeatPassword {
            bindViewModel(email: email)
        }
    }
    
    private func bindViewModel(email: String) {
        viewModel.didSignUpSuccess = { [weak self] in
            DispatchQueue.main.async {
                print("\(email))")
                self?.viewModel.moveToCreateAccount(email: email)
            }
        }
        
        viewModel.didSignUpFailure = {
            errorMessage in
            print(errorMessage)
        }
    }
    
    private func setDelegatesTextField() {
        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        phoneNumberTF.delegate = self
        internationalCodeNumberTF.delegate = self
        repeatPasswordTF.delegate = self
    }
    
    private func hideAllErrorLabels() {
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        repeatPasswordErrorLabel.isHidden = true
        nameErrorLabel.isHidden = true
        phoneNumberErrorLabel.isHidden = true
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = keyboardFrame.height
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = -keyboardHeight / 2
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupUI() {
        [backButton, createAccountLabel, nameLabel, nameTF, nameSeparator, nameErrorLabel,  emailLabel, emailTF, emailSeparator, emailErrorLabel ,stackView, intertationalCodeSeperator, phoneNumberLabel, phoneNumberTF, phoneNumberSeperator, phoneNumberErrorLabel, passwordLabel, passwordTF, passwordSeperator, passwordErrorLabel, repeatPasswordLabel, repeatPasswordTF, repeatPasswordSeperator, repeatPasswordErrorLabel, checkBoxButton, checkStack, createAccountButton].forEach { view.addSubview($0) }
        [internationalCodeNumberTF, internationalCodeButton].forEach { stackView.addArrangedSubview($0) }
        [checkBoxRule].forEach { checkStack.addArrangedSubview($0) }
        
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
            nameLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            nameTF.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            nameSeparator.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 1),
            nameSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            nameErrorLabel.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor, constant: 3),
            nameErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameErrorLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            emailSeparator.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 1),
            emailSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            emailErrorLabel.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor, constant: 3),
            emailErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            stackView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            intertationalCodeSeperator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 1),
            intertationalCodeSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            intertationalCodeSeperator.heightAnchor.constraint(equalToConstant: 1),
            intertationalCodeSeperator.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 5),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberTF.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
            phoneNumberTF.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5),
            phoneNumberTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberTF.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberSeperator.topAnchor.constraint(equalTo: phoneNumberTF.bottomAnchor, constant: 1),
            phoneNumberSeperator.leadingAnchor.constraint(equalTo: intertationalCodeSeperator.trailingAnchor, constant: 5),
            phoneNumberSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberErrorLabel.topAnchor.constraint(equalTo: phoneNumberSeperator.bottomAnchor, constant: 3),
            phoneNumberErrorLabel.leadingAnchor.constraint(equalTo: intertationalCodeSeperator.trailingAnchor, constant: 5),
            phoneNumberErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: phoneNumberErrorLabel.bottomAnchor, constant: 5),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordSeperator.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 1),
            passwordSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordSeperator.bottomAnchor, constant: 3),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordLabel.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 5),
            repeatPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordTF.topAnchor.constraint(equalTo: repeatPasswordLabel.bottomAnchor),
            repeatPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repeatPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repeatPasswordTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordSeperator.topAnchor.constraint(equalTo: repeatPasswordTF.bottomAnchor, constant: 1),
            repeatPasswordSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repeatPasswordSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repeatPasswordSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordErrorLabel.topAnchor.constraint(equalTo: repeatPasswordSeperator.bottomAnchor, constant: 3),
            repeatPasswordErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repeatPasswordErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            checkBoxButton.topAnchor.constraint(equalTo: repeatPasswordErrorLabel.bottomAnchor, constant: 25),
            checkBoxButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 12),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 12)
        ])
        
        NSLayoutConstraint.activate([
            checkStack.topAnchor.constraint(equalTo: repeatPasswordErrorLabel.bottomAnchor, constant: 23),
            checkStack.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 10),
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

extension CreateAccountViewController: UITextFieldDelegate {
    func validateTextField(_ textField: UITextField) {
        let errorText: String?
        
        switch textField {
        case emailTF:
            errorText = viewModel.validateEmail(emailTF.text ?? "")
            emailErrorLabel.text = errorText
            emailErrorLabel.isHidden = (errorText == nil)
            emailSeparator.backgroundColor = (emailTF.text?.isEmpty ?? true) ? .red : .lightGray
            
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
            
        case phoneNumberTF:
            errorText = viewModel.validatePhoneNumber(phoneNumberTF.text ?? "")
            phoneNumberErrorLabel.text = errorText
            phoneNumberErrorLabel.isHidden = (errorText == nil)
            phoneNumberSeperator.backgroundColor = (phoneNumberTF.text?.isEmpty ?? true) ? .red : .lightGray
            
        case nameTF:
            errorText = viewModel.validateName(nameTF.text ?? "")
            nameErrorLabel.text = errorText
            nameErrorLabel.isHidden = (errorText == nil)
            nameSeparator.backgroundColor = (nameTF.text?.isEmpty ?? true) ? .red : .lightGray
            
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateTextField(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF {
            emailTF.becomeFirstResponder()
        } else if textField == emailTF {
            internationalCodeNumberTF.becomeFirstResponder()
        } else if textField == internationalCodeNumberTF {
            phoneNumberTF.becomeFirstResponder()
        } else if textField == phoneNumberTF {
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            repeatPasswordTF.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var labelToAnimate: UILabel?
        
        switch textField {
        case nameTF:
            labelToAnimate = nameLabel
        case emailTF:
            labelToAnimate = emailLabel
        case phoneNumberTF:
            labelToAnimate = phoneNumberLabel
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
extension CreateAccountViewController: CountrySelectionDelegate {
    func didSelectCountry(countryCode: String) {
        internationalCodeNumberTF.text = countryCode
        cobmbineNumber = countryCode
    }
}
