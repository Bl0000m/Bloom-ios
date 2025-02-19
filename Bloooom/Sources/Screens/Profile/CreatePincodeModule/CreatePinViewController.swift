import UIKit

class CreatePinViewController: UIViewController {
    
    private var viewModel: PinViewModelProtocol
    
    private let backButton = UIButton(btnImage: "btnLeft")
    private let closeButton = UIButton(btnImage: "closeButton")
    private let usePinLabel = UILabel(
        text: "ИСПОЛЬЗОВАТЬ КОД-ПАРОЛЬ",
        font: 16,
        textColor: .black
    )
    
    private let createPinCode = UILabel(
        text: "Создайте ПИН-код для быстрого\nдоступа к приложению",
        font: 12,
        textColor: .black
    )
    
    private let pinsView = PinsView()
    private let keypadView = KeypadView()
    
    init(viewModel: PinViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        keypatTappedAction()
        setupAction()
        usePinLabel.textAlignment = .center
        createPinCode.textAlignment = .center
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        pinsView.translatesAutoresizingMaskIntoConstraints = false
        keypadView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        view.addSubview(closeButton)
        view.addSubview(createPinCode)
        view.addSubview(usePinLabel)
        view.addSubview(pinsView)
        view.addSubview(keypadView)
        
        keypadView.lastRowStack.insertArrangedSubview(UIView(), at: 0)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            
            usePinLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            usePinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            createPinCode.topAnchor.constraint(equalTo: usePinLabel.bottomAnchor, constant: 32),
            createPinCode.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createPinCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            createPinCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            
            pinsView.topAnchor.constraint(equalTo: createPinCode.bottomAnchor, constant: 36),
            pinsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keypadView.topAnchor.constraint(equalTo: pinsView.bottomAnchor, constant: 44),
            keypadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keypadView.widthAnchor.constraint(equalToConstant: 265),
            keypadView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170)
        ])
    }
    
    private func bindViewModel() {
        viewModel.pinUpdateHandler = { [weak self] enteredPin in
            self?.updateView(pin: enteredPin)
            self?.processString(enteredPin)
            
            if enteredPin.count > 4 {
                self?.createPinCode.text = "Введите ПИН-код еще раз для\nподтверждения"
            } else {
                self?.createPinCode.text = "Создайте ПИН-код для быстрого\nдоступа к приложению"
            }
        }
        
        viewModel.pinSaved = { [weak self] in
            self?.showPinSavedAlert()
        }
        
        viewModel.showError = { [weak self] message in
            self?.showErrorAlert(message)
        }
    }
    
    private func setupAction() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc private func back() {
        viewModel.moveBack()
    }
    
    @objc private func close() {
        viewModel.closeAction()
    }
    
    func processString(_ input: String) {
        guard input.count == 8 else {
            print("Ошибка: строка должна содержать ровно 8 символов")
            return
        }

        // Разделяем строку
        let firstHalf = input.prefix(4) // Первые три символа
        let secondHalf = input.suffix(4) // Последние три символа

        // Проверяем совпадение символов
        if firstHalf == secondHalf {
            KeychainManager.shared.savePin(String(firstHalf), for: "pinKey")
            viewModel.moveToFaceID()
            print("Пин-код успешно сохранён")
        } else {
            print("Ошибка: половины строки не совпадают")
        }
    }
    
    private func keypatTappedAction() {
        keypadView.keypadButtonTapped = { [weak self] sender in
            guard let title = sender.currentTitle else { return }
            self?.viewModel.didPressKey(title)
        }
    }
    
    func showPinSavedAlert() {
        let alert = UIAlertController(title: "PIN сохранен", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func updateView(pin: String) {
        let currentIndex = max(0, pin.count - 1)
        
        pinsView.confirmPinStackView.isHidden = pin.count <= 4
        
        let isRemovingSymbol = pin.count < (pinsView.previousPinCount ?? -1)
        
        if isRemovingSymbol {
            if pinsView.previousPinCount! > 4 {
                pinsView.confirmPinStackView.subviews[pinsView.previousPinCount! - 5].backgroundColor = .lightGray
            } else if pinsView.previousPinCount! > 0 {
                pinsView.pinStackView.subviews[pinsView.previousPinCount! - 1].backgroundColor = .lightGray
            }
        } else {
            if currentIndex > 3 {
                pinsView.confirmPinStackView.subviews[currentIndex - 4].backgroundColor = .black
            } else {
                pinsView.pinStackView.subviews[currentIndex].backgroundColor = .black
            }
        }
        
        pinsView.previousPinCount = pin.count
    }
}


