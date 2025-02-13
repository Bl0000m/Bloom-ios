import UIKit

class FloristsViewController: UIViewController {
    
    private let viewModel: FloristsViewModelProtocol
    var model: BouquetDetailsModel?
    private let id: Int
    
    private let selectFlorist = UILabel(text: "ВЫБЕРИТЕ ФЛОРИСТА", font: 16, textColor: .black)
    private lazy var backButton = UIButton(btnImage: "btnLeft")
    private let floristsTableView: UITableView = {
        let table = UITableView()
        table.register(FloristCell.self, forCellReuseIdentifier: FloristCell.floristsID)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        bindViewModel()
        setupAction()
        view.backgroundColor = .white
        floristsTableView.dataSource = self
        floristsTableView.delegate = self
    }
    
    init(viewModel: FloristsViewModelProtocol, id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(backButton)
        view.addSubview(selectFlorist)
        view.addSubview(floristsTableView)
    }

    private func setupAction() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        viewModel.goBack()
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            selectFlorist.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            selectFlorist.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            floristsTableView.topAnchor.constraint(equalTo: selectFlorist.bottomAnchor, constant: 35),
            floristsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floristsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            floristsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onFloristsUpdated = { [weak self] result in
            switch result {
            case .success(let florists):
                self?.model = florists
                self?.getBoquetInfo(florists)
                UserDefaults.standard.setValue(self?.model?.branchBouquetInfo.first?.branchId, forKey: "branchId")
                print("\(self?.model?.branchBouquetInfo)")
                self?.floristsTableView.reloadData()
                print("Инфо Букеты получены: \(florists)")
            case .failure(let error):
                print("Ошибка при получении подписок: \(error.localizedDescription)")
            }
        }
        
        viewModel.getFlorists(id: id)
    }
    
    private func getBoquetInfo(_ model: BouquetDetailsModel) {
        let id = UserDefaults.standard.integer(forKey: "orderId")
        viewModel.postOrder(
            orderId: id,
            bouquetId: model.id,
            branchDivisionId: model.branchBouquetInfo.first?.branchId ?? 0,
            assemblyCost: model.branchBouquetInfo.first?.price ?? 0,
            address: model.branchBouquetInfo.first?.address ?? "Адреса нет") { [weak self] result in
                switch result {
                case .success(let response):
                    print("\(response)")
                    self?.viewModel.selectedFlorist(bouquetId: self?.id ?? 0, branchId: response.branchDivisionId)
                case .failure(let error):
                    print("Error - \(error.localizedDescription)")
                }
            }
    }
}

extension FloristsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.branchBouquetInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FloristCell.floristsID, for: indexPath) as? FloristCell else { return UITableViewCell() }
        guard let model = model?.branchBouquetInfo[indexPath.row] else { return UITableViewCell() }
        cell.configure(model: model)
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
        cell.selectFlorist = { [weak self] in
            let id = UserDefaults.standard.integer(forKey: "orderId")
            let branchId = UserDefaults.standard.integer(forKey: "branchId")
            self?.viewModel.selectedFlorist(bouquetId: id, branchId: branchId)
        }
        return cell
    }
}

extension FloristsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(88)
    }
}
