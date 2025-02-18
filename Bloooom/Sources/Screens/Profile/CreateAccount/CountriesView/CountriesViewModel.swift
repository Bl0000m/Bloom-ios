import Foundation

protocol CountriesViewModelProtocol {
    var reloadTableView: (() -> Void)? { get set }
    var onDataUpdated: (() -> Void)? { get set }
    func numberOfCountries() -> Int
    func countryName(at index: Int) -> Country
    var filteredCountries: [Country] { get set }
    func filterCountries(by searchText: String)
}

final class CountriesViewModel: CountriesViewModelProtocol {
    var onDataUpdated: (() -> Void)?
    private(set) var countries: [Country] = []
    var filteredCountries: [Country] = []
    var reloadTableView: (() -> Void)?
    private weak var countriesCoordinator: CountriesCoordinator?
    
    init(countriesCoordinator: CountriesCoordinator?) {
        self.countriesCoordinator = countriesCoordinator
        fetchCountries()
    }
    
    func numberOfCountries() -> Int {
        return filteredCountries.isEmpty ? countries.count : filteredCountries.count
    }
    
    func countryName(at index: Int) -> Country {
        return filteredCountries.isEmpty ? countries[index] : filteredCountries[index]
    }
    
    private func fetchCountries() {
        UserAPIManager.shared.loadCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                self?.filteredCountries = countries
                self?.reloadTableView?()
            case .failure(let error):
                print("Failed to load countries: \(error)")
            }
        }
    }
    
    func filterCountries(by searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter {
                $0.nameRu.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        onDataUpdated?()
    }
}
