import UIKit

class CustomCalendarView: UIView {
    // MARK: - Public Properties
    var selectedDates: [Date] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var onDateSelected: ((String) -> Void)?
    // MARK: - Private Properties
    private var currentDate = Date()
    private var calendar = Calendar.current
    private let gmtTimeZone = TimeZone(abbreviation: "GMT")!

    private let monthLabel = UILabel(
        text: "",
        font: 16,
        textColor: .black
    )
    
    private let previousButton = UIButton(btnImage: "expandLeft")
    private let nextButton = UIButton(btnImage: "expandRight")

    private let daysOfWeekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.calendarCellID)
        return collectionView
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
        setupWeekdayLabels()
        updateUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupActions()
        setupWeekdayLabels()
        updateUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        let headerStack = UIStackView(arrangedSubviews: [previousButton, monthLabel, nextButton])
        headerStack.axis = .horizontal
        headerStack.distribution = .equalCentering
        headerStack.alignment = .center
        addSubview(headerStack)

        headerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])

        addSubview(daysOfWeekStackView)
        daysOfWeekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysOfWeekStackView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 10),
            daysOfWeekStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            daysOfWeekStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            daysOfWeekStackView.heightAnchor.constraint(equalToConstant: 30)
        ])

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: daysOfWeekStackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 290)
        ])
    }

    private func setupWeekdayLabels() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ru_RU")
        
        let weekdaySymbols = calendar.shortStandaloneWeekdaySymbols
        let reorderedWeekdays = Array(weekdaySymbols[1...6] + weekdaySymbols[0...0])

        for weekday in reorderedWeekdays {
            let label = UILabel()
            label.text = weekday.uppercased()
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = .black
            daysOfWeekStackView.addArrangedSubview(label)
        }
    }


    private func setupActions() {
        previousButton.addTarget(self, action: #selector(handlePreviousMonth), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNextMonth), for: .touchUpInside)
    }

    // MARK: - Update UI
    private func updateUI() {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        formatter.locale = Locale(identifier: "ru_RU")
        monthLabel.text = formatter.string(from: currentDate).uppercased()
        
        collectionView.reloadData()
    }
    
    // MARK: - Actions
    @objc private func handlePreviousMonth() {
        if let prevMonthDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = prevMonthDate
            updateUI()
        }
    }

    @objc private func handleNextMonth() {
        if let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
            currentDate = nextMonthDate
            updateUI() 
        }
    }
    
    private func convertDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, EEEE"
        return formatter.string(from: date)
    }
    
    private func convertStringToDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, EEEE" // Используйте такой же формат, который использовался при создании строки
        return formatter.date(from: dateString)
    }
}

extension CustomCalendarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        let firstWeekday = (calendar.component(.weekday, from: startOfMonth) - calendar.firstWeekday + 7) % 7
        return range.count + firstWeekday
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.calendarCellID, for: indexPath) as? CalendarCell else {
            fatalError("Unable to dequeue CalendarDateCell")
        }

        calendar.timeZone = gmtTimeZone

        let startOfDay = calendar.startOfDay(for: currentDate)
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: startOfDay))!
        let firstWeekday = (calendar.component(.weekday, from: startOfMonth) - calendar.firstWeekday + 7) % 7
        let totalDaysInMonth = calendar.range(of: .day, in: .month, for: startOfMonth)?.count ?? 0

        let currentDayIndex = indexPath.item - firstWeekday + 1

        if currentDayIndex > 0 && currentDayIndex <= totalDaysInMonth {
            let day = currentDayIndex
            let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!

            // Преобразуем строки в даты и проверяем, содержится ли текущая дата в selectedDates
            let isSelected = selectedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) })


            //let isSelected = selectedDates.contains(where: { $0 == convertDateToString(date) })

            cell.configure(with: day, isSelected: isSelected)

            if date < Date() && !calendar.isDateInToday(date) {
                cell.label.textColor = .gray
                cell.isUserInteractionEnabled = false
            } else {
                if calendar.isDateInToday(date) {
                    cell.label.textColor = isSelected ? .white : .red
                } else {
                    cell.label.textColor = isSelected ? .white : .black
                }
                cell.isUserInteractionEnabled = true
            }
        } else {
            cell.clear()
            cell.isUserInteractionEnabled = false
            cell.alpha = 0.5
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        calendar.timeZone = gmtTimeZone
        
        // Начало дня для текущей даты
        let startOfDay = calendar.startOfDay(for: currentDate)
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: startOfDay))!
        
        // Количество дней в текущем месяце
        let totalDaysInMonth = calendar.range(of: .day, in: .month, for: startOfMonth)?.count ?? 0
        
        // Первый день недели текущего месяца
        let firstWeekday = (calendar.component(.weekday, from: startOfMonth) - calendar.firstWeekday + 7) % 7
        
        // Индекс текущего дня в коллекции
        let currentDayIndex = indexPath.item - firstWeekday + 1
        
        var selectedDate: Date?

        // Если день в пределах текущего месяца
        if currentDayIndex > 0 && currentDayIndex <= totalDaysInMonth {
            selectedDate = calendar.date(byAdding: .day, value: currentDayIndex - 1, to: startOfMonth)
        } else if currentDayIndex <= 0 {
            // День из предыдущего месяца
            let previousMonth = calendar.date(byAdding: .month, value: -1, to: startOfMonth)!
            let daysInPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)?.count ?? 0
            selectedDate = calendar.date(byAdding: .day, value: daysInPreviousMonth + currentDayIndex - 1, to: previousMonth)
        } else if currentDayIndex > totalDaysInMonth {
            // День из следующего месяца
            let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
            
            // Количество дней в следующем месяце
            let daysInNextMonth = calendar.range(of: .day, in: .month, for: nextMonth)?.count ?? 0
            
            // Индекс дня из следующего месяца
            let nextMonthDayIndex = currentDayIndex - totalDaysInMonth - 1
            
            // Проверяем, чтобы индекс дня не выходил за пределы следующего месяца
            if nextMonthDayIndex < daysInNextMonth {
                selectedDate = calendar.date(byAdding: .day, value: nextMonthDayIndex, to: nextMonth)
            }
        }

        // Проверка на существование даты
        guard let date = selectedDate else { return }
        
        // Начало дня для выбранной даты
        let startOfDayDate = calendar.startOfDay(for: date)
        
        // Преобразуем дату в строку
        let formattedDate = convertDateToString(startOfDayDate)
        
        // Добавляем или удаляем дату из массива выбранных дат
        let isDateAlreadySelected = selectedDates.contains(where: { calendar.isDate($0, inSameDayAs: startOfDayDate) })
        
        if isDateAlreadySelected {
            selectedDates.removeAll { calendar.isDate($0, inSameDayAs: startOfDayDate) }
        } else {
            selectedDates.append(startOfDayDate)
        }

        // Вызов блока onDateSelected с отформатированной датой
        onDateSelected?(formattedDate.uppercased())
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 6 * 5) / 7
        return CGSize(width: width, height: width)
    }
}
