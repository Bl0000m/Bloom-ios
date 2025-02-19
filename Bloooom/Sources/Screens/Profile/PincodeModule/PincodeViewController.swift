import UIKit

class PincodeViewController: UIViewController {

    private let viewModel: PincodeViewModelProtocol
    
    private let backButton = UIButton(btnImage: "btnLeft")
    private let welcomeLabel = UILabel(text: "РАДЫ ВИДЕТЬ ВАС СНОВА", font: 16, textColor: .black)
    private let entryPincode = UILabel(
        text: "Введите код для быстрого доступа\nк приложению",
        font: 12,
        textColor: .black
    )
    
    private let faceIDIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "faceIDIcon")
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    private let pinsView = PinsView()
    private let keypadView = KeypadView()
    private let forgotPinPasswordButton = UIButton(
        text: "Забыли код-пароль?",
        textColor: .black,
        font: 12
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        entryPincode.textAlignment = .center
        setupViews()
        setupLayout()
        bindViewModel()
        keypatTappedAction()
        buttonAction()
    }
    
    init(viewModel: PincodeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [welcomeLabel, entryPincode, pinsView, keypadView, forgotPinPasswordButton].forEach { view.addSubview($0) }
        keypadView.lastRowStack.insertArrangedSubview(faceIDIcon, at: 0)
    }
    
    private func bindViewModel() {
        viewModel.pinUpdateHandler = { [weak self] enteredPin in
            self?.updateView(pin: enteredPin)
            self?.processString(enteredPin)
        }
    }
    
    private func keypatTappedAction() {
        keypadView.keypadButtonTapped = { [weak self] sender in
            guard let title = sender.currentTitle else { return }
            
            // Устанавливаем цвет текста при нажатии
            sender.setTitleColor(.lightGray, for: .highlighted)
            
            // Изменяем цвет границы для состояния .highlighted
            let originalBorderColor = sender.layer.borderColor // Сохраняем оригинальный цвет
            sender.layer.borderColor = UIColor.lightGray.cgColor
            sender.layer.borderWidth = 0.5 // Устанавливаем ширину границы
            
            // Возвращаем цвет границы обратно после короткой задержки
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                sender.layer.borderColor = originalBorderColor
            }
            
            self?.viewModel.didPressKey(title)
        }
    }

    
    private func buttonAction() {
        forgotPinPasswordButton.addTarget(self, action: #selector(onForgotTap), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(moveToFaceID), for: .touchUpInside)
    }
    
    @objc private func onForgotTap() {
        viewModel.moveToForgot()
    }
    
    @objc private func moveToFaceID() {
        viewModel.moveToFaceId()
    }
    
    private func processString(_ input: String) {
        guard input.count == 4 else {
            print("Ошибка: строка должна содержать ровно 4 символа")
            return
        }

        let enteredPin = input

        if let savedPin = KeychainManager.shared.getSavedPin(for: "pinKey") {
            if enteredPin == savedPin {
                print("Пин-коды совпадают")
                entryPincode.text = "Успешно. Ваш ПИН-код подтвержден!"
                entryPincode.textColor = .systemGreen
                pinsView.successPinStack.isHidden = false
                pinsView.confirmPinStackView.isHidden = true
                pinsView.pinStackView.isHidden = true
                pinsView.warningPinStackView.isHidden = true
//                viewModel.refreshAccessToken(refreshToken: UserDefaults.standard.string(forKey: "userRefreshToken")!) { result in
//                    switch result {
//                    case .success:
//                        print("Токен успешно обновлен")
//                    case .failure(let error):
//                        print("Ошибка обновления токена: \(error.localizedDescription)")
//                    }
//                }
                moveToMain()
            } else {
                print("Ошибка: введённый PIN не совпадает с сохранённым")
                entryPincode.text = "Неверный пин-код. Пожалуйста,\nпопробуйте снова"
                entryPincode.textColor = .red
                pinsView.confirmPinStackView.isHidden = true
                pinsView.warningPinStackView.isHidden = false
                pinsView.successPinStack.isHidden = true
                pinsView.pinStackView.isHidden = true
            }
        } else {
            print("Ошибка: PIN не найден в Keychain")
        }
    }

    private func moveToMain() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.viewModel.moveToMain()
        }
    }
    
    private func setupLayout() {
        pinsView.translatesAutoresizingMaskIntoConstraints = false
        keypadView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            entryPincode.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32),
            entryPincode.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            entryPincode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            entryPincode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            
            pinsView.topAnchor.constraint(equalTo: entryPincode.bottomAnchor, constant: 56),
            pinsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keypadView.topAnchor.constraint(equalTo: pinsView.bottomAnchor, constant: 44),
            keypadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keypadView.widthAnchor.constraint(equalToConstant: 265),
           // keypadView.heightAnchor.constraint(equalToConstant: 327),
            
            forgotPinPasswordButton.topAnchor.constraint(equalTo: keypadView.bottomAnchor, constant: 35),
            forgotPinPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPinPasswordButton.heightAnchor.constraint(equalToConstant: 14),
            forgotPinPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
    func updateView(pin: String) {
        let pinStackSubviews = pinsView.pinStackView.subviews
        let warningPinStackView = pinsView.warningPinStackView.subviews
        let successPinStack = pinsView.successPinStack.subviews
        
        let currentIndex = max(0, pin.count - 1)
        let previousPinCount = pinsView.previousPinCount ?? 0
        
        let isRemovingSymbol = pin.count < previousPinCount
        
        if isRemovingSymbol {
            if previousPinCount > 0 {
                let index = previousPinCount - 1
                if index >= 0 {
                    if index < pinStackSubviews.count {
                        pinStackSubviews[index].backgroundColor = .lightGray
                    }
                    if index < warningPinStackView.count {
                        warningPinStackView[index].backgroundColor = .lightGray
                    }
                    if index < successPinStack.count {
                        successPinStack[index].backgroundColor = .lightGray
                    }
                }
            }
        } else {
            if currentIndex >= 0 {
                if currentIndex < pinStackSubviews.count {
                    pinStackSubviews[currentIndex].backgroundColor = .black
                }
                if currentIndex < warningPinStackView.count {
                    warningPinStackView[currentIndex].backgroundColor = .red
                }
                if currentIndex < successPinStack.count {
                    successPinStack[currentIndex].backgroundColor = .systemGreen
                }
            }
        }
        
        pinsView.previousPinCount = pin.count
    }
}
