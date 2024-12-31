import UIKit

class DetailsOrderViewController: UIViewController {

    private let viewModel: DetailsOrderViewModelProtocol
    
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
        descTitle: "ВЫБЕРИТЕ ВРЕМЯ И ДАТУ ДОСТАВКИ"
    )
    
    private let addressDeliveryView = CustomDetailsOrderView(
        mainTitle: "АДРЕС ДОСТАВКИ",
        image: "pin",
        descTitle: "ВЫБЕРИТЕ АДРЕС ДОСТАВКИ"
    )
    
    private lazy var continueButton = UIButton(title: "ПРОДОЛЖИТЬ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        configureCustomViews()
        view.backgroundColor = .white
        
        buquetView.moveToDetails = { [weak self] in
            self?.viewModel.goToGallery()
        }
    }
 
    init(viewModel: DetailsOrderViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
