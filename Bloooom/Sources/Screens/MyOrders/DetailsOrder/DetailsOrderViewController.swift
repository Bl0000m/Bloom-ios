import UIKit

class DetailsOrderViewController: UIViewController {

    private let viewModel: DetailsOrderViewModelProtocol
    private let id: Int
    
    private lazy var closeButton = UIButton(btnImage: "closeButton")
    
    private let orderDetailTitle = UILabel(
        text: "ДЕТАЛИ ЗАКАЗА",
        font: 16,
        textColor: .black
    )
    
    private let buquetView = CustomDetailsOrderView(
        mainTitle: "БУКЕТ",
        image: "flower",
        descTitle: "ВЫБЕРИТЕ БУКЕТ"
    )
    
    private let dateDeliveryView = CustomDetailsOrderView(
        mainTitle: "ДАТА ДОСТАВКИ",
        image: "time",
        descTitle: ""
    )
    
    private let addressDeliveryView = CustomDetailsOrderView(
        mainTitle: "АДРЕС ДОСТАВКИ",
        image: "pin",
        descTitle: ""
    )
    
    private lazy var continueButton = UIButton(title: "ПРОДОЛЖИТЬ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        configureCustomViews()
        view.backgroundColor = .white
        bindViewModel()
        setupAction()
        buquetView.moveToDetails = { [weak self] in
            self?.viewModel.goToGallery()
        }
    }
 
    init(viewModel: DetailsOrderViewModelProtocol, id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAction() {
        closeButton.addTarget(self, action: #selector(goToOrder), for: .touchUpInside)
    }
    
    @objc private func goToOrder() {
        viewModel.goToListOrders()
    }
    
    private func bindViewModel() {
        viewModel.fetchUserSubscriptions(id: id)
        
        viewModel.onSubscriptionsFetched = { [weak self] result in
            switch result {
            case .success(let order):
                let startTime = order.deliveryStartTime
                let endTime = order.deliveryEndTime
                let deliveryDate = order.deliveryDate
                let formmatedDateString = self?.formatDeliveryDate(startTime: startTime, endTime: endTime, date: deliveryDate)
                self?.dateDeliveryView.updateDescription(deliveryTime: formmatedDateString ?? "")
                self?.addressDeliveryView.updateAddress(streetName: (order.address?.street.uppercased() ?? "ВЫБЕРИТЕ АДРЕС ДОСТАВКИ") + " " + (order.address?.building ?? ""))
                print("\(order)")
            case .failure(let error):
                print("Ошибка при получении подписок: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func formatDeliveryDate(startTime: String, endTime: String, date: String) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "ru_RU")
        timeFormatter.dateFormat = "HH:mm" // Формат для парсинга времени
        
        let startDate = timeFormatter.date(from: startTime)
        let endDate = timeFormatter.date(from: endTime)
        
        let displayTimeFormatter = DateFormatter()
        displayTimeFormatter.locale = Locale(identifier: "ru_RU")
        displayTimeFormatter.dateFormat = "HH:mm" // Убираем нули
        
        let formattedStartTime = startDate.map { displayTimeFormatter.string(from: $0) } ?? startTime
        let formattedEndTime = endDate.map { displayTimeFormatter.string(from: $0) } ?? endTime
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd" // Формат для парсинга даты
        
        let deliveryDate = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "d MMMM, EEEE" // Формат для отображения даты
        
        let formattedDate = dateFormatter.string(from: deliveryDate).uppercased()
        
        return "\(formattedStartTime) - \(formattedEndTime), \(formattedDate)"
    }
    
    private func configureCustomViews() {
        buquetView.translatesAutoresizingMaskIntoConstraints = false
        dateDeliveryView.translatesAutoresizingMaskIntoConstraints = false
        addressDeliveryView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViews() {
        [closeButton, orderDetailTitle, buquetView, dateDeliveryView, addressDeliveryView, continueButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            orderDetailTitle.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40),
            orderDetailTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            buquetView.topAnchor.constraint(equalTo: orderDetailTitle.bottomAnchor, constant: 35),
            buquetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buquetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buquetView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            dateDeliveryView.topAnchor.constraint(equalTo: buquetView.bottomAnchor, constant: 35),
            dateDeliveryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateDeliveryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateDeliveryView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            addressDeliveryView.topAnchor.constraint(equalTo: dateDeliveryView.bottomAnchor, constant: 35),
            addressDeliveryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressDeliveryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressDeliveryView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            continueButton.heightAnchor.constraint(equalToConstant: 26),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}
