import UIKit

class UserAddressViewController: UIViewController {

    private let viewModel: UserAddressViewModelProtocol
    private let id: Int
    private let backButton = UIButton(btnImage: "btnLeft")
    private let detailOrderTitle = UILabel(text: "АДРЕС ДОСТАВКИ", font: 16, textColor: .black)
    private let addAnotherAddresButton = UIButton(title: "УКАЗАТЬ ДРУГОЙ АДРЕС")
    private let emptyAddressView = EmptyAdressView()
    private var addressModel: [AnotherAddressModel] = []
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["ДОСТАВКА", "САМОВЫВОЗ"])
        control.selectedSegmentIndex = 0
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        control.backgroundColor = .white
        control.selectedSegmentTintColor = .black
        control.layer.borderColor = UIColor.black.cgColor
        control.layer.borderWidth = 0.5
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let addressTableView: UITableView = {
        let table = UITableView()
        table.register(UserAddressCell.self, forCellReuseIdentifier: UserAddressCell.addressId)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupAction()
        setupTableView()
        bindViewModel()
        
        view.backgroundColor = .white
    }
    
    init(viewModel: UserAddressViewModelProtocol, id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        viewModel.onAddressUpdated = { [weak self] result in
            switch result {
            case .success(let address):
                self?.addressModel = address
                self?.addressTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        if addressModel.count == 0 {
            addressTableView.isHidden = false
            emptyAddressView.isHidden = true
        } else {
            addressTableView.isHidden = true
            emptyAddressView.isHidden = false
        }
        
        viewModel.onAddressError = { error in
            print(error)
        }
        
        viewModel.fetchAddresses(id: id)
    }
    
    private func setupViews() {
        emptyAddressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyAddressView)
        [backButton, detailOrderTitle, segmentedControl, addressTableView, addAnotherAddresButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            detailOrderTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 41),
            detailOrderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: detailOrderTitle.bottomAnchor, constant: 35),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 31)
        ])
        
        NSLayoutConstraint.activate([
            emptyAddressView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 90),
            emptyAddressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            emptyAddressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            emptyAddressView.heightAnchor.constraint(equalToConstant: 130)
        ])
        NSLayoutConstraint.activate([
            addressTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            addressTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addAnotherAddresButton.topAnchor.constraint(equalTo: addressTableView.bottomAnchor, constant: 15),
            addAnotherAddresButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            addAnotherAddresButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            addAnotherAddresButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            addAnotherAddresButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupAction() {
        backButton.addTarget(self, action: #selector(moveToBack), for: .touchUpInside)
        addAnotherAddresButton.addTarget(self, action: #selector(moveToAnother), for: .touchUpInside)
    }
    
    private func setupTableView() {
        addressTableView.dataSource = self
        addressTableView.delegate = self
    }
    
    @objc private func moveToBack() {
        viewModel.goBack()
    }
    
    @objc private func moveToAnother() {
        viewModel.moveToAnotherAddress()
    }
}

extension UserAddressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserAddressCell.addressId, for: indexPath) as? UserAddressCell else { return UITableViewCell() }
        let model = addressModel[indexPath.row]
        cell.configure(cityNameText: model.city, streetNameText: model.street)
        return cell
    }
    
    
}

extension UserAddressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
