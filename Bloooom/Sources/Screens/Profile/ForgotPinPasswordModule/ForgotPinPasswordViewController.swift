import UIKit

class ForgotPinPasswordViewController: UIViewController {

    private var viewModel: ForgotPinPasswordViewModelProtocol
    
    private let stackView = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .leading, spacing: 8)
    private let backButton = UIButton(btnImage: "btnLeft")
    private let mainTitle = UILabel(text: "ЗАБЫЛИ ПАРОЛЬ", font: 16, alignment: .left, textColor: .black)
    private let mainSubTitle = UILabel(
        text: "Пожалуйста, введите ваш электронный адрес\nдля сброса пароля",
        font: 12,
        alignment: .left,
        textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    )
    private let emailLabel = UILabel(text: "ЭЛЕКТРОННАЯ ПОЧТА", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let emailLabel1 = UILabel(text: "ЭЛЕКТРОННАЯ ПОЧТА", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let emailTextField = UITextField(placeHolder: "", keyboard: .emailAddress)
    private let seperatorLine = UIView(backgroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let emailErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private lazy var confirmButton = UIButton(title: "ПРОДОЛЖИТЬ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActionButton()
        view.backgroundColor = .white
        emailTextField.delegate = self
        emailTextField.autocapitalizationType = .none
        navigationController?.setNavigationBarHidden(true, animated: false)
        emailErrorLabel.isHidden = true
        emailLabel.isHidden = true
    }
    
    init(viewModel: ForgotPinPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hideAllErrorLabels() {
        emailErrorLabel.isHidden = true
    }
    
    private func setupUI() {
        [backButton, stackView, emailLabel, emailLabel1, emailTextField, seperatorLine, emailErrorLabel, confirmButton].forEach { view.addSubview($0) }
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
            emailLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel1.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            emailLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
       
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            seperatorLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3),
            seperatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            seperatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            emailErrorLabel.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor, constant: 3),
            emailErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 70),
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
        hideAllErrorLabels()
        validateTextField(emailTextField)
        guard let email = emailTextField.text, !email.isEmpty else { return }
        viewModel.resetCode(email: email)
        
        bindViewModel(email: email)
    }
    
    @objc private func toBackAction() {
        viewModel.moveToBack()
    }
    
    private func bindViewModel(email: String) {
        print("EMail - \(email)")
        viewModel.onEmailConfimed = { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.moveToEmailCheckCode(email: email)
            }
        }
    }
}

extension ForgotPinPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var labelToAnimate: UILabel?
        
        switch textField {
        case emailTextField:
            labelToAnimate = emailLabel
            emailLabel1.isHidden = true
            emailLabel.isHidden = false
        default:
            break
        }
        
        if let label = labelToAnimate {
            UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
                label.font = .systemFont(ofSize: 8, weight: .regular)
            }, completion: nil)
        }
    }
    
    func validateTextField(_ textField: UITextField) {
        let errorText: String?
        
        switch textField {
        case emailTextField:
            errorText = viewModel.validateEmail(emailTextField.text ?? "")
            emailErrorLabel.text = errorText
            emailErrorLabel.isHidden = (errorText == nil)
            seperatorLine.backgroundColor = (emailTextField.text?.isEmpty ?? true) ? .red : #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        default:
            break
        }
    }
}
