import UIKit

protocol CountrySelectionDelegate: AnyObject {
    func didSelectCountry(countryCode: String)
}

class CountriesCodesViewController: UIViewController {

    private var countriesViewModel: CountriesViewModelProtocol
    weak var delegate: CountrySelectionDelegate?
    
    private let countriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CountriesCodesCell.self, forCellReuseIdentifier: CountriesCodesCell.countriesCellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    init(countriesViewModel: CountriesViewModelProtocol) {
        self.countriesViewModel = countriesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        
        view.addSubview(countriesTableView)
        
        NSLayoutConstraint.activate([
            countriesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CountriesCodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.numberOfCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CountriesCodesCell.countriesCellID,
            for: indexPath
        ) as? CountriesCodesCell else { return UITableViewCell()
        }
        
        let country = countriesViewModel.countryName(at: indexPath.row)
        cell.configure(country: country)
        return cell
    }
}

extension CountriesCodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContryCode = countriesViewModel.countryName(at: indexPath.row)
        delegate?.didSelectCountry(countryCode: selectedContryCode.dialCode)
        dismiss(animated: true)
    }
}
