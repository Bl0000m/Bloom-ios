import UIKit

class OrederDetailsViewController: UIViewController {

    private var viewModel: OrderDetailsViewModelProtocol
    private let monthNames: [Date]
    var orderDetails: [OrderDetailsModel] = []
    private lazy var closeButton = UIButton(btnImage: "closeButton")
    private let fillOrderDetails = UILabel(text: "ЗАПОЛНИТЕ ДЕТАЛИ ЗАКАЗА", font: 16, textColor: .black)
    private let countOrdersTitle = UILabel(text: "ВСЕГО ЗАКАЗОВ: ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let countOrders = UILabel(text: "", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    private let orderDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderDetailsCell.self, forCellReuseIdentifier: OrderDetailsCell.orderDetailsID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupExtensions()
        bindViewModel()
        setupAction()
        view.backgroundColor = .white
        
        let id = UserDefaults.standard.integer(forKey: "userID")
        viewModel.fetchUserSubscriptions(id: id)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.presentModalViewController()
        }
    }
    
    init(viewModel: OrderDetailsViewModelProtocol, monthNames: [Date]) {
        self.viewModel = viewModel
        self.monthNames = monthNames
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDate(count: Int) {
        countOrders.text = "\(count)"
    }
   
    private func presentModalViewController() {
        let modalViewController = CompleteOrderViewController()
        modalViewController.modalPresentationStyle = .overFullScreen
        modalViewController.modalTransitionStyle = .crossDissolve
        
        present(modalViewController, animated: true)
    }
    
    private func setupViews() {
        [closeButton, fillOrderDetails, countOrdersTitle, countOrders, orderDetailsTableView].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            fillOrderDetails.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40),
            fillOrderDetails.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            countOrdersTitle.topAnchor.constraint(equalTo: fillOrderDetails.bottomAnchor, constant: 20),
            countOrdersTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            countOrders.topAnchor.constraint(equalTo: fillOrderDetails.bottomAnchor, constant: 20),
            countOrders.leadingAnchor.constraint(equalTo: countOrdersTitle.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            orderDetailsTableView.topAnchor.constraint(equalTo: countOrdersTitle.bottomAnchor, constant: 20),
            orderDetailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            orderDetailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            orderDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupExtensions() {
        orderDetailsTableView.delegate = self
        orderDetailsTableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.onSubscriptionsFetched = { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.orderDetails = subscriptions
                self?.orderDetailsTableView.reloadData()
                self?.setDate(count: subscriptions.count)
                print("Подписки получены: \(subscriptions)")
            case .failure(let error):
                print("Ошибка при получении подписок: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupAction() {
        closeButton.addTarget(self, action: #selector(moveMySubsribers), for: .touchUpInside)
    }
    
    @objc private func moveMySubsribers() {
        viewModel.moveToSubscribers()
    }
}

extension OrederDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderDetailsCell.orderDetailsID,
            for: indexPath
        ) as? OrderDetailsCell else { return UITableViewCell() }
        
        // Получаем дату из массива monthNames
        let date = orderDetails[indexPath.row]
        UserDefaults.standard.setValue(date.id, forKey: "orderId")
        cell.selectionStyle = .none
        // Настроим DateFormatter для парсинга строки в дату
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd" // Формат даты из JSON
        inputDateFormatter.locale = Locale(identifier: "ru_RU")

        // Настроим DateFormatter для преобразования даты в строку
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd MMMM yyyy"
        outputDateFormatter.locale = Locale(identifier: "ru_RU")

        if let date = inputDateFormatter.date(from: date.deliveryDate) {
            let dateString = outputDateFormatter.string(from: date)
            cell.configure(timeDelivery: dateString.uppercased())
            print("Форматированная дата: \(dateString)")
        } else {
            print("Ошибка: невозможно преобразовать дату")
        }
        
        return cell
    }

}

extension OrederDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToOrderDetails()
    }
}
