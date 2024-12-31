import UIKit

class VerificationUserViewController: UIViewController {
    
    private var viewModel: VerificationUserViewModelProtocol
    var email: String
    
    private let stackView = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 10
    )
    
    private let resentCodeStack = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 5
    )
    private let backButton = UIButton(btnImage: "btnLeft")
    private let confirmCodeLabel = UILabel(text: "ПОДТВЕРДИТЕ ЭЛЕКТРОННЫЙ АДРЕС", font: 16, textColor: .black)
    private let confirmCodeDescriptionLabel = UILabel(
        text: "Мы отправили вам письмо с 4-значным кодом",
        font: 12,
        textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    )
    
    private let writeCodeLabel = UILabel(text: "ВВЕДИТЕ КОД", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let writeCodeLabel1 = UILabel(text: "ВВЕДИТЕ КОД", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let writeCodeTextField = UITextField(placeHolder: "", keyboard: .numberPad)
    private let seperatorLine = UIView(backgroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    
    private let resendLabel = UILabel(text: "Отправить повторно через: ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let timerLabel = UILabel(text: "", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let resendButton = UIButton(text: "Отправить повторно", textColor: .black, font: 12)
    private let resenSeperator = UIView(backgroundColor: .black)
    
    private let confirmButton = UIButton(title: "ПОДТВЕРДИТЬ")
    
    private var timer: Timer?
    private var timeRemaining = 60 // 1 minute
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        startTimer()
        timerStarted()
        setupAction()
        writeCodeTextField.delegate = self
        bindViewModel()
        writeCodeLabel.isHidden = true
    }
    
    init(viewModel: VerificationUserViewModelProtocol, email: String) {
        self.viewModel = viewModel
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAction() {
        resendButton.addTarget(self, action: #selector(startTimerAction), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.onCodeConfirmed = { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.onMainPage()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.viewModel.onError?(errorMessage)
        }
    }
    
    private func setupUI() {
        [
            backButton,
            stackView,
            writeCodeLabel,
            writeCodeLabel1,
            writeCodeTextField,
            seperatorLine,
            resentCodeStack,
            resendButton,
            resenSeperator,
            confirmButton
        ].forEach { view.addSubview($0) }
        [confirmCodeLabel, confirmCodeDescriptionLabel].forEach { stackView.addArrangedSubview($0) }
        [resendLabel, timerLabel].forEach { resentCodeStack.addArrangedSubview($0) }
        
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
            writeCodeLabel1.topAnchor.constraint(equalTo: writeCodeLabel.bottomAnchor, constant: 16),
            writeCodeLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
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
            resentCodeStack.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor, constant: 35),
            resentCodeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            resentCodeStack.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            resendButton.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor, constant: 35),
            resendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            resendButton.heightAnchor.constraint(equalToConstant: 14),
            resendButton.widthAnchor.constraint(equalToConstant: 122)
        ])
        
        NSLayoutConstraint.activate([
            resenSeperator.topAnchor.constraint(equalTo: resendButton.bottomAnchor, constant: 1),
            resenSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            resenSeperator.heightAnchor.constraint(equalToConstant: 1),
            resenSeperator.widthAnchor.constraint(equalToConstant: 122)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: resentCodeStack.bottomAnchor, constant: 178),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            confirmButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        startTime()
    }
    
    @objc private func confirmButtonTapped() {
        guard let code = writeCodeTextField.text, !code.isEmpty else {
            print("Пожалуйста, введите код")
            return
        }
        confirmCodeAction(code: code)
    }
    
    @objc private func goBackAction() {
        viewModel.goBack()
    }
    
    @objc private func startTimerAction() {
        print("\(email)")
        viewModel.resetCode(email: email)
        startTime()
    }
    
    @objc private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            timerLabel.text = formatTime(timeRemaining)
        } else {
            timer?.invalidate()
            timer = nil
            timerFinished()
        }
    }
    
    private func startTime() {
        timer?.invalidate()
        timerLabel.text = formatTime(timeRemaining)
        timeRemaining = 60
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerStarted()
    }
    
    private func timerFinished() {
        resendLabel.isHidden = true
        timerLabel.isHidden = true
        resentCodeStack.isHidden = true
        resendButton.isHidden = false
        resenSeperator.isHidden = false
    }
    
    private func timerStarted() {
        resendLabel.isHidden = false
        timerLabel.isHidden = false
        resentCodeStack.isHidden = false
        resendButton.isHidden = true
        resenSeperator.isHidden = true
    }
    
    private func confirmCodeAction(code: String) {
        viewModel.confirmCode(email: email, code: code)
    }
}

extension VerificationUserViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var labelToAnimate: UILabel?
        
        switch textField {
        case writeCodeTextField:
            labelToAnimate = writeCodeLabel
            writeCodeLabel1.isHidden = true
            writeCodeLabel.isHidden = false
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
