import UIKit

class EditOrderDetailsViewController: UIViewController {

    
    private let viewModel: EditOrderDetailsViewModelProtocol
    private var model: EditOrderDetailsModel?
    
    private let id: Int
    
    private lazy var closeButton = UIButton(btnImage: "closeButton")
    private let detailsOrderTitle = UILabel(text: "ДЕТАЛИ ЗАКАЗА", font: 16, textColor: .black)
    private let bouquetInfoView = EditOrderDetailsCustom()
    private var dateDeliveryView = CustomDetailsOrderView(
        mainTitle: "ДАТА ДОСТАВКИ",
        image: "time",
        descTitle: ""
    )
    
    private lazy var addressDelivery = CustomDetailsOrderView (
        mainTitle: "АДРЕС ДОСТАВКИ",
        image: "pin",
        descTitle: "ВЫБЕРИТЕ АДРЕС ДОСТАВКИ"
    )
    
    private lazy var continueButton = UIButton(title: "ПРОДОЛЖИТЬ")
    
    init(viewModel: EditOrderDetailsViewModelProtocol, id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        bindViewModel()
        setupActions()
        view.backgroundColor = .white
        viewModel.getBoquetInfo(id: id)
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        viewModel.fetchUserSubscriptions(id: orderId)
    }
    
    private func setupViews() {
        [closeButton, detailsOrderTitle, bouquetInfoView, dateDeliveryView, addressDelivery, continueButton].forEach { view.addSubview($0) }
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

    private func setupActions() {
        addressDelivery.moveToAddAdress = { [weak self] in
            self?.viewModel.goToAddress()
        }
        
        dateDeliveryView.moveToDetails = {
            
        }
        
        continueButton.addTarget(self, action: #selector(goToListOrders), for: .touchUpInside)
    }
    
    @objc private func goToListOrders() {
        viewModel.goToListOrders()
    }

    private func bindViewModel() {
        viewModel.onSubscriptionsFetched = { [weak self] result in
            switch result {
            case .success(let order):
                self?.model = order
                let startTime = order.deliveryStartTime
                let endTime = order.deliveryEndTime
                let deliveryDate = order.deliveryDate
                let formmatedDateString = self?.formatDeliveryDate(startTime: startTime, endTime: endTime, date: deliveryDate)
                self?.dateDeliveryView.updateDescription(deliveryTime: formmatedDateString ?? "")
                self?.addressDelivery.updateAddress(streetName: (order.address?.street.uppercased() ?? "") + " " + (order.address?.building ?? ""))
                self?.bouquetInfoView.configure(order, order.assemblyCost ?? 0.0)
                print("\(order)")
            case .failure(let error):
                print("Ошибка при получении подписок: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupLayout() {
        bouquetInfoView.translatesAutoresizingMaskIntoConstraints = false
        dateDeliveryView.translatesAutoresizingMaskIntoConstraints = false
        addressDelivery.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            detailsOrderTitle.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40),
            detailsOrderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            bouquetInfoView.topAnchor.constraint(equalTo: detailsOrderTitle.bottomAnchor, constant: 35),
            bouquetInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bouquetInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bouquetInfoView.heightAnchor.constraint(equalToConstant: 292)
        ])
        
        NSLayoutConstraint.activate([
            dateDeliveryView.topAnchor.constraint(equalTo: bouquetInfoView.bottomAnchor, constant: 35),
            dateDeliveryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateDeliveryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateDeliveryView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            addressDelivery.topAnchor.constraint(equalTo: dateDeliveryView.bottomAnchor, constant: 35),
            addressDelivery.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressDelivery.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressDelivery.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: addressDelivery.bottomAnchor, constant: 40),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            continueButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
}
