import UIKit

class CheckEmailViewController: UIViewController {

    private var viewModel: CheckEmailViewModelProtocol
    var email: String
    
    private let stackView = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 10
    )
    
    private let backButton = UIButton(btnImage: "btnLeft")
    private let confirmCodeLabel = UILabel(text: "ПРОВЕРЬТЕ СВОЮ ПОЧТУ", font: 16, textColor: .black)
    private let confirmCodeDescriptionLabel = UILabel(
        text: "",
        font: 12,
        textColor: .lightGray
    )
    
    private let writeCodeLabel = UILabel(text: "ВВЕДИТЕ КОД", font: 12, textColor: .lightGray)
    private let writeCodeTextField = UITextField(placeHolder: "", keyboard: .numberPad)
    private let seperatorLine = UIView(backgroundColor: .lightGray)
    
    private let confirmButton = UIButton(title: "ПОДТВЕРДИТЬ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        bindViewModel()
        setupAction()
        view.backgroundColor = .white
        writeCodeTextField.delegate = self
        confirmCodeDescriptionLabel.text = "Мы отправили ссылку на \(email)\nВведите 4-значный код, указанный в письме"
    }
    
    init(viewModel: CheckEmailViewModelProtocol, email: String) {
        self.viewModel = viewModel
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [backButton, stackView, writeCodeLabel, writeCodeTextField, seperatorLine, confirmButton].forEach { view.addSubview($0) }
        [confirmCodeLabel, confirmCodeDescriptionLabel].forEach { stackView.addArrangedSubview($0) }
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
            writeCodeLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            writeCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            writeCodeTextField.topAnchor.constraint(equalTo: writeCodeLabel.bottomAnchor),
            writeCodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            writeCodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            writeCodeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            seperatorLine.topAnchor.constraint(equalTo: writeCodeTextField.bottomAnchor, constant: 1),
            seperatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            seperatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor, constant: 178),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            confirmButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupAction() {
        confirmButton.addTarget(self, action: #selector(onConfrimCode), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        viewModel.moveBack()
    }
    
    @objc private func onConfrimCode() {
        guard let code = writeCodeTextField.text, !code.isEmpty else {
            print("Пожалуйста, введите код")
            return
        }
        confirmCodeAction(code: code)
    }
    
    private func bindViewModel() {
        viewModel.onCodeConfirmed = { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.goToConfirmCode()
            }
        }
        
        viewModel.onError = { [weak self] error in
            self?.viewModel.onError?(error)
        }
    }
    
    private func confirmCodeAction(code: String) {
        viewModel.confirmCode(email: email, code: code)
    }
}

extension CheckEmailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.transition(with: writeCodeLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.writeCodeLabel.font = .systemFont(ofSize: 8, weight: .regular)
        }, completion: nil)
        
    }
}
