import UIKit

class CalendarViewController: UIViewController {

    private let viewModel: CalendarViewModelProtocol
    private let customCalendarView = CustomCalendarView()
    var month: String?
    private let gmtTimeZone = TimeZone(abbreviation: "GMT")!
    let dateFormatter = DateFormatter()
    
    private var startTimeDeliveryText = ""
    private var endTimeDeliveryText = ""
    private var isSelected = false

    private let timeDeliveryStack = UIStackView(
        axis: .horizontal,
        distribution: .fillProportionally,
        alignment: .center,
        spacing: 10
    )
    private let backButton = UIButton(btnImage: "btnLeft")
    private let selectDayLabel = UILabel(
        text: "ВЫБЕРИТЕ КОЛИЧЕСТВО ДНЕЙ",
        font: 16,
        textColor: .black
    )
    
    private let calendarDaySubtitle = UILabel(
        text: "Выберите даты на календаре, и мы доставим\nцветы точно в выбранные вами дни",
        font: 12,
        textColor: .lightGray
    )
    
    private lazy var morningTime = UIButton(title: "8:00 - 12:59")
    private lazy var afternoonTime = UIButton(title: "13:00 - 17:59")
    private lazy var eveningTime = UIButton(title: "18:00 - 22:59")
    
    private let continueButton = UIButton(title: "ПРОДОЛЖИТЬ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupBindings()
        setupActions()
        configureContinueButton()
        view.backgroundColor = .white
        continueButton.layer.borderColor = UIColor.lightGray.cgColor
        continueButton.setTitleColor(.lightGray, for: .normal)
        continueButton.isEnabled = false
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    init(viewModel: CalendarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        customCalendarView.translatesAutoresizingMaskIntoConstraints = false
        [backButton, selectDayLabel, calendarDaySubtitle, timeDeliveryStack, customCalendarView, continueButton].forEach { view.addSubview($0) }
        [morningTime, afternoonTime, eveningTime].forEach { timeDeliveryStack.addArrangedSubview($0) }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(selectMonth), for: .touchUpInside)
        morningTime.addTarget(self, action: #selector(selectMorningTime), for: .touchUpInside)
        afternoonTime.addTarget(self, action: #selector(selectAfternoonTime), for: .touchUpInside)
        eveningTime.addTarget(self, action: #selector(selectEveningTime), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        viewModel.moveBack()
    }
    
    @objc private func selectMonth() {
        viewModel.sendSubscription(
            dates: customCalendarView.selectedDates,
            startTime: startTimeDeliveryText,
            endTime: endTimeDeliveryText
        ) { [weak self] result in
            switch result {
            case .success(let responseData):
                print("\(responseData)")
                UserDefaults.standard.setValue(responseData.id, forKey: "userID")
                self?.viewModel.moveToCompleteOrder(selectedDates: self?.customCalendarView.selectedDates ?? [])
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func selectMorningTime(_ sender: UIButton) {
        resetButtons()
        startTimeDeliveryText = "08:00"
        endTimeDeliveryText = "12:59"
        isSelected = true
        configureContinueButton()
        print("Morning Time: \(startTimeDeliveryText) - \(endTimeDeliveryText), Selected: \(isSelected)")
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    
    @objc private func selectAfternoonTime(_ sender: UIButton) {
        resetButtons()
        isSelected = true
        startTimeDeliveryText = "13:00"
        endTimeDeliveryText = "17:59"
        configureContinueButton()
        print("Afternoon Time: \(startTimeDeliveryText) - \(endTimeDeliveryText), Selected: \(isSelected)")
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    
    @objc private func selectEveningTime(_ sender: UIButton) {
        resetButtons()
        isSelected = true
        startTimeDeliveryText = "18:00"
        endTimeDeliveryText = "22:59"
        configureContinueButton()
        print("Evening Time: \(startTimeDeliveryText) - \(endTimeDeliveryText), Selected: \(isSelected)")
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    
    private func configureContinueButton() {
        if isSelected {
            continueButton.layer.borderColor = UIColor.black.cgColor
            continueButton.setTitleColor(.black, for: .normal)
            continueButton.isEnabled = true
        } else {
            continueButton.layer.borderColor = UIColor.lightGray.cgColor
            continueButton.setTitleColor(.lightGray, for: .normal)
            continueButton.isEnabled = false
        }
    }
    
    private func resetButtons() {
        morningTime.backgroundColor = .white
        morningTime.setTitleColor(.black, for: .normal)
        
        afternoonTime.backgroundColor = .white
        afternoonTime.setTitleColor(.black, for: .normal)
        
        eveningTime.backgroundColor = .white
        eveningTime.setTitleColor(.black, for: .normal)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            selectDayLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            selectDayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            calendarDaySubtitle.topAnchor.constraint(equalTo: selectDayLabel.bottomAnchor, constant: 10),
            calendarDaySubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            timeDeliveryStack.topAnchor.constraint(equalTo: calendarDaySubtitle.bottomAnchor, constant: 35),
            timeDeliveryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            timeDeliveryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            timeDeliveryStack.heightAnchor.constraint(equalToConstant: 25)
        ])
      
        NSLayoutConstraint.activate([
            morningTime.heightAnchor.constraint(equalToConstant: 25),
            afternoonTime.heightAnchor.constraint(equalToConstant: 25),
            eveningTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            customCalendarView.topAnchor.constraint(equalTo: timeDeliveryStack.bottomAnchor, constant: 35),
            customCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            customCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            continueButton.heightAnchor.constraint(equalToConstant: 32),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
    
    private func setupBindings() {
        customCalendarView.onDateSelected = { [weak self] selectedDate in
            guard let self = self else { return }

            print("Выбрана дата: \(selectedDate)")
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.dateStyle = .medium
            formatter.dateFormat = "d MMMM, EEEE"
            print("Отформатированная дата: \(selectedDate.uppercased())")
        }
    }
}
