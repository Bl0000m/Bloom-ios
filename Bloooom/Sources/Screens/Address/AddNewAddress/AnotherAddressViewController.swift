import UIKit

class AnotherAddressViewController: UIViewController {
    
    private let viewModel: AnotherAddressViewModelProtocol
    private var cobmbineNumber = ""
    
    private let backButton = UIButton(btnImage: "btnLeft")
    private let id: Int
    private let mainTitle = UILabel(
        text: "АДРЕС ДОСТАВКИ",
        font: 16,
        textColor: .black
    )
    
    private let userAddressView = CustomAdressView()
    private let confirmButton = UIButton(title: "ПОДТВЕРДИТЬ")
    private let rulesStar = UILabel(text: "*", font: 12, textColor: .red)
    private let rulesLabel = UILabel(text: "- Поля обязательные для заполнения", font: 12, textColor: .red)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayout()
        bindViewModel()
        setupAction()
        setupTextFields()
        setupKeyboardNotifications()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    init(viewModel: AnotherAddressViewModelProtocol, id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupAction() {
        confirmButton.addTarget(self, action: #selector(sendAddress), for: .touchUpInside)
        userAddressView.internationCodeBtn.addTarget(self, action: #selector(selectedCountryCode), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(moveToBack), for: .touchUpInside)
    }
    
    @objc private func moveToBack() {
        viewModel.goBack()
    }
    
    @objc private func sendAddress() {
        
        guard let phoneNumber = userAddressView.phoneNumberTF.text, !phoneNumber.isEmpty else {
            return
        }

        let combineNumber = cobmbineNumber + phoneNumber

        guard let city = userAddressView.cityNameLabel.text, !city.isEmpty,
              let street = userAddressView.streetTF.text, !street.isEmpty,
              let building = userAddressView.buildingTF.text, !building.isEmpty,
              !combineNumber.isEmpty
        else {
            return
        }

        let appartment = userAddressView.appartmentTF.text ?? ""
        let entrance = userAddressView.entranceTF.text ?? ""
        let intercom = userAddressView.intercomTF.text ?? ""
        let floor = userAddressView.floorTF.text ?? ""
        let comment = userAddressView.commentTF.text ?? ""
        
        viewModel.sendAddressData(
            city: city,
            street: street,
            building: building,
            appartment: appartment,
            entrance: entrance,
            intercom: intercom,
            floor: Int(floor),
            phoneNumber: combineNumber,
            comment: comment,
            postalCode: nil,
            long: nil,
            lati: nil,
            orderId: UserDefaults.standard.integer(forKey: "orderId")
        )
    }
    
    @objc private func selectedCountryCode() {
        viewModel.selectionCountryCode(delegate: self)
    }
    
    private func disableConfirmButton() {
        confirmButton.isEnabled = false
        confirmButton.setTitleColor(.gray, for: .disabled)
        confirmButton.layer.borderColor = UIColor.gray.cgColor
    }

    private func enableConfirmButton() {
        confirmButton.isEnabled = true
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.layer.borderColor = UIColor.black.cgColor
    }
    
    private func bindViewModel() {
        viewModel.onAddressUpdated = { [weak self] result in
            switch result {
            case .success(let address):
                self?.userAddressView.cityNameLabel.text = address.branchDivisionInfoDto?.address
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }

        viewModel.didSignUpSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.moveToDetailOrder()
            }
        }
        
        viewModel.didSignUpFailure = { errorMessage in
            print(errorMessage)
        }
        
        viewModel.fetchAddress(id: UserDefaults.standard.integer(forKey: "branchId"))
    }
    
    private func setupTextFields() {
        userAddressView.streetTF.delegate = self
        userAddressView.buildingTF.delegate = self
        userAddressView.appartmentTF.delegate = self
        userAddressView.entranceTF.delegate = self
        userAddressView.intercomTF.delegate = self
        userAddressView.floorTF.delegate = self
        userAddressView.phoneNumberTF.delegate = self
        userAddressView.commentTF.delegate = self
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
    
    @objc private func goBack() {
        
    }
    
    private func setupViews() {
        userAddressView.translatesAutoresizingMaskIntoConstraints = false
        [backButton, mainTitle, userAddressView, rulesStar, rulesLabel, confirmButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            userAddressView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 35),
            userAddressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            userAddressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
        ])
        
        NSLayoutConstraint.activate([
            rulesStar.topAnchor.constraint(equalTo: userAddressView.bottomAnchor, constant: 15),
            rulesStar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            rulesLabel.topAnchor.constraint(equalTo: userAddressView.bottomAnchor, constant: 15),
            rulesLabel.leadingAnchor.constraint(equalTo: rulesStar.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            confirmButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

extension AnotherAddressViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if textField == userAddressView.streetTF {
            userAddressView.buildingTF.becomeFirstResponder()
        } else if textField == userAddressView.streetTF {
            userAddressView.appartmentTF.becomeFirstResponder()
        } else if textField == userAddressView.entranceTF {
            userAddressView.intercomTF.becomeFirstResponder()
        } else if textField == userAddressView.intercomTF {
            userAddressView.floorTF.becomeFirstResponder()
        } else if textField == userAddressView.floorTF {
            userAddressView.phoneNumberTF.becomeFirstResponder()
        } else if textField == userAddressView.phoneNumberTF {
            userAddressView.commentTF.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var labelToAnimate: UILabel?
        
        switch textField {
        case userAddressView.streetTF:
            labelToAnimate = userAddressView.streetLabel
            userAddressView.streetLabel.isHidden = false
            userAddressView.streetLabel1.isHidden = true
            userAddressView.streetStar.isHidden = true
        case userAddressView.buildingTF:
            labelToAnimate = userAddressView.buildingLabel
            userAddressView.buildingLabel.isHidden = false
            userAddressView.buildingLabel1.isHidden = true
            userAddressView.buildingStar.isHidden = true
        case userAddressView.appartmentTF:
            let isAppartmentEmpty = (userAddressView.appartmentTF.text?.isEmpty ?? true)
            labelToAnimate = userAddressView.appartmentLabel
            userAddressView.appartmentLabel.isHidden = !isAppartmentEmpty
            userAddressView.appartmentLabel1.isHidden = isAppartmentEmpty
        case userAddressView.entranceTF:
            let isEntranceEmpty = (userAddressView.entranceTF.text?.isEmpty ?? true)
            labelToAnimate = userAddressView.entranceLabel
            userAddressView.entranceLabel.isHidden = !isEntranceEmpty
            userAddressView.entranceLabel1.isHidden = isEntranceEmpty
        case userAddressView.intercomTF:
            let isIntercomEmpty = (userAddressView.intercomTF.text?.isEmpty ?? true)
            labelToAnimate = userAddressView.intercomeLabel
            userAddressView.intercomeLabel.isHidden = !isIntercomEmpty
            userAddressView.intercomeLabel1.isHidden = isIntercomEmpty
        case userAddressView.floorTF:
            let isFloorEmpty = (userAddressView.floorTF.text?.isEmpty ?? true)
            labelToAnimate = userAddressView.floorLabel
            userAddressView.floorLabel.isHidden = !isFloorEmpty
            userAddressView.floorLabel1.isHidden = isFloorEmpty
        case userAddressView.phoneNumberTF:
            let isPhoneEmpty = (userAddressView.phoneNumberTF.text?.isEmpty ?? true)
            labelToAnimate = userAddressView.phoneNumberLabel
            userAddressView.phoneNumberLabel.isHidden = false
            userAddressView.phoneNumberLabel1.isHidden = true
            userAddressView.phoneNumberStar.isHidden = true
        case userAddressView.commentTF:
            let isCommentEmpty = (userAddressView.commentTF.text?.isEmpty ?? true)
            labelToAnimate = userAddressView.commentLabel
            userAddressView.commentLabel.isHidden = !isCommentEmpty
            userAddressView.commentLabel1.isHidden = isCommentEmpty
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
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == userAddressView.phoneNumberTF {
            // Ограничиваем ввод в `phoneNumberTF` максимум 10 символами
            let isValidLength = newText.count <= 10
            if isValidLength {
                updateButtonState(text: newText)
            }
            return isValidLength
        } else {
            // Запрещаем пробелы в остальных полях
            let isValidInput = !string.contains(" ")
            if isValidInput {
                updateButtonState(text: newText)
            }
            return isValidInput
        }
    }

    // Обновляем состояние кнопки
    func updateButtonState(text: String? = nil) {
        let currentText = text ?? userAddressView.phoneNumberTF.text ?? ""
        confirmButton.isEnabled = currentText.count >= 10
    }

}

extension AnotherAddressViewController: CountrySelectionDelegate {
    func didSelectCountry(countryCode: String) {
        userAddressView.internationalCodeTF.text = countryCode
        cobmbineNumber = countryCode
    }
}
