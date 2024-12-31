import UIKit

class CreateSubscribeViewController: UIViewController {

    private let viewModel: CreateSubscribeViewModelProtocol
    
    private lazy var backButton = UIButton(btnImage: "btnLeft")
    private lazy var expandButton = UIButton(btnImage: "expand")
    private let createSubscribeTitle = UILabel(text: "СОЗДАТЬ ПОДПИСКУ", font: 16, textColor: .black)
    private let createSubscribeSubtitle = UILabel(
        text: "Придумайте название и выберите тип из списка\nдля оформления подписки.",
        font: 12,
        textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    )
    
    private let nameSubscribe = UILabel(text: "НАЗВАНИЕ ПОДПИСКИ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let nameSubscribe1 = UILabel(text: "НАЗВАНИЕ ПОДПИСКИ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let nameSubscribeTF = UITextField(placeHolder: "", keyboard: .default)
    private let nameSubscribeSeparator = UIView(backgroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let nameSubscribeErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    
    private let typeSubscribe = UILabel(text: "ТИП ПОДПИСКИ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let typeSubscribe1 = UILabel(text: "ТИП ПОДПИСКИ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let typeSubscribeTF = UITextField(placeHolder: "", keyboard: .default)
    private let typeSubscribeSeparator = UIView(backgroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let typeSubscribeErrorLabel = UILabel(text: "", font: 8, alignment: .left, textColor: .red)
    private lazy var createSubscribeButton = UIButton(title: "СОЗДАТЬ ПОДПИСКУ")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayout()
        setupActions()
        setupHideLabels()
        setupButtonOnTextField()
        setupHideAllErrosLabels()
        
        nameSubscribeTF.delegate = self
        typeSubscribeTF.delegate = self
        typeSubscribeTF.isUserInteractionEnabled = true
        typeSubscribeTF.inputView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameSubscribeErrorLabel.isHidden = true
        typeSubscribeErrorLabel.isHidden = true
        nameSubscribeSeparator.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        typeSubscribeSeparator.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    init(viewModel: CreateSubscribeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [backButton, createSubscribeTitle, createSubscribeSubtitle, nameSubscribe, nameSubscribe1, nameSubscribeTF, nameSubscribeSeparator, nameSubscribeErrorLabel, typeSubscribe, typeSubscribe1, typeSubscribeTF, typeSubscribeSeparator, typeSubscribeErrorLabel, createSubscribeButton].forEach { view.addSubview($0) }
    }
    
    private func validateInputs() -> Bool {
        var isValid = true
        
        if nameSubscribeTF.text?.isEmpty ?? true {
            nameSubscribeErrorLabel.text = "Введите имя подписки"
            nameSubscribeErrorLabel.isHidden = false
            isValid = false
        } else {
            nameSubscribeErrorLabel.isHidden = true
        }
        
        if typeSubscribeTF.text?.isEmpty ?? true {
            typeSubscribeErrorLabel.text = "Выберите тип подписки"
            typeSubscribeErrorLabel.isHidden = false
            isValid = false
        } else {
            typeSubscribeErrorLabel.isHidden = true
        }
        
        return isValid
    }

    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            createSubscribeTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            createSubscribeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            createSubscribeSubtitle.topAnchor.constraint(equalTo: createSubscribeTitle.bottomAnchor, constant: 17),
            createSubscribeSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            nameSubscribe.topAnchor.constraint(equalTo: createSubscribeSubtitle.bottomAnchor, constant: 40),
            nameSubscribe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            nameSubscribe1.topAnchor.constraint(equalTo: nameSubscribe.bottomAnchor, constant: 16),
            nameSubscribe1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            nameSubscribeTF.topAnchor.constraint(equalTo: nameSubscribe.bottomAnchor),
            nameSubscribeTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            nameSubscribeTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            nameSubscribeTF.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            nameSubscribeSeparator.topAnchor.constraint(equalTo: nameSubscribeTF.bottomAnchor, constant: 1),
            nameSubscribeSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            nameSubscribeSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            nameSubscribeSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            nameSubscribeErrorLabel.topAnchor.constraint(equalTo: nameSubscribeSeparator.bottomAnchor, constant: 5),
            nameSubscribeErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            nameSubscribeErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21)
        ])
        
        NSLayoutConstraint.activate([
            typeSubscribe.topAnchor.constraint(equalTo: nameSubscribeErrorLabel.bottomAnchor),
            typeSubscribe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            typeSubscribe1.topAnchor.constraint(equalTo: typeSubscribe.bottomAnchor, constant: 16),
            typeSubscribe1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            typeSubscribeTF.topAnchor.constraint(equalTo: typeSubscribe.bottomAnchor),
            typeSubscribeTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            typeSubscribeTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            typeSubscribeTF.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            typeSubscribeSeparator.topAnchor.constraint(equalTo: typeSubscribeTF.bottomAnchor, constant: 1),
            typeSubscribeSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            typeSubscribeSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            typeSubscribeSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            typeSubscribeErrorLabel.topAnchor.constraint(equalTo: typeSubscribeSeparator.bottomAnchor, constant: 5),
            typeSubscribeErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            typeSubscribeErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21)
        ])
        
        NSLayoutConstraint.activate([
            createSubscribeButton.topAnchor.constraint(equalTo: typeSubscribeErrorLabel.bottomAnchor, constant: 30),
            createSubscribeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            createSubscribeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            createSubscribeButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupButtonOnTextField() {
        typeSubscribeTF.rightView = expandButton
        typeSubscribeTF.rightViewMode = .always
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        createSubscribeButton.addTarget(self, action: #selector(createSubscribe), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        viewModel.moveToBack()
    }
    
    @objc private func createSubscribe() {
        setupHideAllErrosLabels()
        guard let subscribeName = nameSubscribeTF.text, let subscribeType = typeSubscribeTF.text else { return }
        if validateInputs() {
            viewModel.createSubscribe(subscribeName: subscribeName, subscribeType: subscribeType)
            guard let subscribeName = nameSubscribeTF.text else { return }
            UserDefaults.standard.set(subscribeName, forKey: "nameSubscribe")
            print("Создание подписки...")
        } else {
            validateTextField(nameSubscribeTF)
            validateTextField(typeSubscribeTF)
            print("Ошибка: Проверьте введенные данные")
        }
    }
    
    private func setupHideLabels() {
        nameSubscribe.isHidden = true
        typeSubscribe.isHidden = true
    }
    
    private func setupHideAllErrosLabels() {
        nameSubscribeErrorLabel.isHidden = true
        typeSubscribeErrorLabel.isHidden = true
    }
    
    private func setText() {
        let optionMenu = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        
        let every2days = UIAlertAction(title: "Любые цветы каждые 2 дня", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.typeSubscribeTF.text = "Любые цветы каждые 2 дня"
        })
        
        let chooseAnyPeriod = UIAlertAction(title: "Избранная композиция за период", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.typeSubscribeTF.text = "Избранная композиция за период"
        })
        
        every2days.setValue(UIColor.darkGray, forKey: "titleTextColor")
        chooseAnyPeriod.setValue(UIColor.darkGray, forKey: "titleTextColor")
        
        optionMenu.addAction(every2days)
        optionMenu.addAction(chooseAnyPeriod)
        present(optionMenu, animated: true)
        
    }
}

extension CreateSubscribeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var labelToAnimate: UILabel?
        switch textField {
        case nameSubscribeTF:
            labelToAnimate = nameSubscribe
            nameSubscribe1.isHidden = true
            nameSubscribe.isHidden = false
        case typeSubscribeTF:
            labelToAnimate = typeSubscribe
            typeSubscribeTF.resignFirstResponder()
            typeSubscribe1.isHidden = true
            typeSubscribe.isHidden = false
            setText()
        default:
            break
        }
        
        if let label = labelToAnimate {
            UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
                label.font = .systemFont(ofSize: 8, weight: .regular)
            }, completion: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case typeSubscribeTF:
            return false
        default:
            return true
        }
    }
    
    func validateTextField(_ textField: UITextField) {
        let errorText: String?
        
        switch textField {
        case nameSubscribeTF:
            errorText = viewModel.validateSubscribeName(nameSubscribeTF.text ?? "")
            nameSubscribeErrorLabel.text = errorText
            nameSubscribeErrorLabel.isHidden = (errorText == nil)
            nameSubscribeSeparator.backgroundColor = (nameSubscribeTF.text?.isEmpty ?? true) ? .red : #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        case typeSubscribeTF:
            errorText = viewModel.validateTypeSubscribe(typeSubscribeTF.text ?? "")
            typeSubscribeErrorLabel.text = errorText
            typeSubscribeErrorLabel.isHidden = (errorText == nil)
            typeSubscribeSeparator.backgroundColor = (typeSubscribeTF.text?.isEmpty ?? true) ? .red : #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameSubscribeTF:
            validateTextField(nameSubscribeTF)
            if nameSubscribeTF.text?.isEmpty == true {
                nameSubscribe1.isHidden = false
                nameSubscribe.isHidden = true
            }
        case typeSubscribeTF:
            validateTextField(typeSubscribeTF)
            if typeSubscribeTF.text?.isEmpty == true {
                typeSubscribe1.isHidden = false
                typeSubscribe.isHidden = true
            }
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameSubscribeTF {
            typeSubscribeTF.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        
        return true
    }

}
