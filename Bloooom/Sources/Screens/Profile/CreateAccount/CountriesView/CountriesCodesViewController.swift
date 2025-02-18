import UIKit

protocol CountrySelectionDelegate: AnyObject {
    func didSelectCountry(countryCode: String)
}

class CountriesCodesViewController: UIViewController {

    private var countriesViewModel: CountriesViewModelProtocol
    weak var delegate: CountrySelectionDelegate?
    private let searchBar = UISearchBar()
    private var filteredCountries: [Country] = []
    
    private let countriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CountriesCodesCell.self, forCellReuseIdentifier: CountriesCodesCell.countriesCellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        bindViewModel()
        view.backgroundColor = .white
    }
    
    init(countriesViewModel: CountriesViewModelProtocol) {
        self.countriesViewModel = countriesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        countriesViewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.countriesTableView.reloadData()
            }
            
        }
        
        countriesViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.countriesTableView.reloadData()
            }
        }
    }
    
    private func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "ПОИСК"
    }

    private func setupTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        searchBar.delegate = self
        
        view.addSubview(countriesTableView)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            countriesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CountriesCodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.filteredCountries.isEmpty ? countriesViewModel.numberOfCountries() : countriesViewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CountriesCodesCell.countriesCellID,
            for: indexPath
        ) as? CountriesCodesCell else { return UITableViewCell()
        }
        
        let country = countriesViewModel.filteredCountries.isEmpty ? countriesViewModel.countryName(at: indexPath.row) : countriesViewModel.filteredCountries[indexPath.row]
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

extension CountriesCodesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countriesViewModel.filterCountries(by: searchText)
    }
}
